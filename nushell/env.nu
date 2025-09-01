$env.XDG_CONFIG_HOME = ($env.XDG_CONFIG_HOME? | default ($env.HOME | path join ".config"))
$env.XDG_CACHE_HOME = ($env.XDG_CACHE_HOME? | default ($env.HOME | path join ".cache"))

mkdir ($nu.data-dir | path join "vendor" "autoload")

if (which starship | is-not-empty) {
  $env.STARSHIP_CONFIG = ($env.XDG_CONFIG_HOME | path join "starship" "config.toml")
  $env.STARSHIP_CACHE = $env.XDG_CACHE_HOME

  starship init nu | save -f ($nu.data-dir | path join "vendor" "autoload" "starship.nu")
}

if (which zoxide | is-not-empty) {
  zoxide init nushell | save -f ($nu.data-dir | path join "vendor" "autoload" "zoxide.nu")
}

$env.TOPIARY_CONFIG_FILE = ($env.XDG_CONFIG_HOME | path join topiary languages.ncl)
$env.TOPIARY_LANGUAGE_DIR = ($env.XDG_CONFIG_HOME | path join topiary languages)

if (($env.path | grep .cargo) | is-empty) {
  if (($env.HOME | path join ".cargo" "bin") | path exists) {
    $env.PATH = [($env.HOME | path join ".cargo" "bin")] ++ $env.PATH
  }
}
