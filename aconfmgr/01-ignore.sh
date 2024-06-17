IgnorePath '/var/*'
IgnorePath '/tmp/*'
IgnorePath '/boot/*'
IgnorePath '/usr/*'

whitelist=( 'lightdm*' 'locale.gen' 'keyd*' )
IgnorePathsExcept /etc "${whitelist[@]}"

IgnorePackage --foreign yay
IgnorePackage --foreign aconfmgr-git
