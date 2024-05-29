IgnorePath '/var/*'
IgnorePath '/tmp/*'
IgnorePath '/boot/*'
IgnorePath '/usr/*'

whitelist=( 'lightdm*' 'locale.gen' )
IgnorePathsExcept /etc "${whitelist[@]}"

IgnorePackage --foreign yay
IgnorePackage --foreign aconfmgr-git
