function CreateFileIfDoesntExist () {
    local file="$1"

    if [[ -h "$file" || -e "$file" ]]
    then
        printf '%s' "$file"
        return
    fi

    CreateFile "$@"
}

function IgnorePathsExcept() {
    # Ignore all path in given directory (first parameter)
    # that do not math the given white list (second parameter)

    local search_dir=$1
    shift
    local white_list=("$@")
    local find_args=()
    local ignore_path
    for ignore_path in "${white_list[@]}"; do
        local base="$ignore_path"
        # Add all base paths to the argument list as well otherwise
        # -prune will prevent us from reaching the whitelisted files.
        while [ "$base" != '.' ]; do
            find_args+=(-path "$search_dir/$base" -o)
            base="$(dirname "$base")"
        done
    done
    # Find everything except given whitelist and the directory
    # searched from.
    find "$search_dir" -not \( "${find_args[@]}" -path "$search_dir" \) -prune | \
        while read file; do
        if [[ -d "$file" ]]; then
            IgnorePath "$file/*"
        else
            IgnorePath "$file"
        fi
    done
}

# SystemdEnable
#     [--no-alias|--no-wanted-by]
#     [--name CUSTOM_NAME]
#     [--type system|user]
#     [--from-file|package] unit
#
# Enable a systemd unit file.
#
# Caveat: This will not process Also directives, as it might in theory require
# handling files from other packages. In addition you might not want to install
# both this unit and the Also unit.
#
# --no-alias and --no-wanted-by can be used to disable installing those types of
# links. This is useful if you want to just use socket and dbus activation and
# don't want the unit to start on boot.
#
# --name is to be used for parameterised units ("foo@.service"), to provide the
# parameter.
#
# --type defaults to system but can be used to override and install default user
# units in /etc/systemd/user.
#
# --from-file is used when unit file is installed by aconfmgr instead of pulled
# from a package. In this case the package name MUST be skipped. Otherwise it is
# REQUIRED.
function SystemdEnable() {
    local type=system
    local do_alias=1 do_wanted_by=1 from_file=0

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --no-alias) do_alias=0 ;;
            --no-wanted-by) do_wanted_by=0 ;;
            --from-file) from_file=1 ;;
            --name)
                local name_override=$2
                shift 1
                ;;
            --type)
                type=$2
                shift 1
                ;;
            *)
                break
                ;;
        esac
        shift 1
    done

    if [[ $from_file -eq 0 ]]; then
        [[ $# -ne 2 ]] && FatalError "Expected 2 arguments, got $#."
        local pkg="$1"
        local unit="$2"
    else
        [[ $# -ne 1 ]] && FatalError "Expected 1 argument, got $#."
        local unit="$1"
    fi

    if [[ "$type" != "system" && "$type" != "user" ]]; then
        FatalError "Unkown type ${type}"
    fi

    local filename="${unit##*/}"

    # Find the unit, either from package data or already added to the output
    # directory
    if [[ $from_file -eq 0 ]]; then
        local unit_source="$tmp_dir/systemd_helpers/$pkg/$filename"

        if [[ ! -f "$unit_source" ]]; then
            mkdir -p "$tmp_dir/systemd_helpers/$pkg"
            AconfGetPackageOriginalFile "$pkg" "$unit" > "$unit_source"
        fi
    else
        local unit_source="$output_dir/files/$unit"
    fi

    [[ ! -f "$unit_source" ]] && FatalError "$unit_source not found"

    local target
    local oIFS="$IFS"
    # Process WantedBy lines (if enabled)
    if [[ $do_wanted_by -eq 1 ]]; then
        local name="${name_override:-${filename}}"
        local -a wantedby

        if grep -q WantedBy= "$unit_source"; then
            IFS=$' \n\t'
            wantedby=( $(grep -E '^WantedBy=' "$unit_source" | cut -d= -f2) )
            IFS="$oIFS"
            for target in "${wantedby[@]}"; do
                CreateLink "/etc/systemd/${type}/${target}.wants/${name}" "${unit}"
            done
        fi
    fi

    # Process Alias lines (if enabled)
    if [[ $do_alias -eq 1 ]]; then
        local -a aliases

        if grep -q Alias= "$unit_source"; then
            IFS=$' \n\t'
            aliases=( $(grep -E '^Alias=' "$unit_source" | cut -d= -f2) )
            IFS="$oIFS"
            for target in "${aliases[@]}"; do
                CreateLink "/etc/systemd/${type}/${target}" "${unit}"
            done
        fi
    fi
}
