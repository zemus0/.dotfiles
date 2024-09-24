{ config, lib, pkgs, ... }:

let
	buildTheme = { name, version, src, themeIni ? [] }:
		pkgs.stdenv.mkDerivation rec {
			pname = "sddm-theme-${name}";
			inherit version src;

			buildCommand = ''
				dir=$out/share/sddm/themes/${name}
				doc=$out/share/doc/${pname}

				mkdir -p $dir $doc
				if [ -d $src/${name} ]; then
					srcDir=$src/${name}
				else
					srcDir=$src
				fi
				cp -r $srcDir/* $dir/
				for f in $dir/{AUTHORS,COPYING,LICENSE,README,*.md,*.txt}; do
					test -f $f && mv $f $doc/
				done
				chmod 644 $dir/theme.conf

				${lib.concatMapStringsSep "\n" (e: '' ${pkgs.crudini}/bin/crudini --set --inplace $dir/theme.conf \ "${e.section}" "${e.key}" "${e.value}" '') themeIni}
			'';
		};

	theme = {
		pkg = rec {
			name = "sugar-candy";
			version = "1.6";
			src = pkgs.fetchFromGitHub {
				owner = "Kangie";
				repo = "sddm-${name}";
				rev = "v${version}";
				sha256 = "sha256-p2d7I0UBP63baW/q9MexYJQcqSmZ0L5rkwK3n66gmqM=";
			};
			themeIni = [
				{ section = "General"; key = "background"; value = "/usr/share/wallpapers/wal"; }
				{ section = "General"; key = "ForceHideCompletePassword"; value = "true"; }
			];
		};
		deps = with pkgs; [
			libsForQt5.qt5.qtgraphicaleffects
			libsForQt5.qt5.qtquickcontrols2
			libsForQt5.qt5.qtsvg
		];
	};

	themeName = theme.pkg.name;

	packages = [ (buildTheme theme.pkg) ] ++ theme.deps;

in
{
	systemd.tmpfiles.rules = [
		"d /usr/share/wallpapers - root root"
		"f /usr/share/wallpapers/wal 0766 root root"
	];

	environment.systemPackages = packages;

	services.displayManager.sddm.theme = themeName;
}
