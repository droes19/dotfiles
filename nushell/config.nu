if ($nu.os-info.name == "windows") {
	$env.XDG_CONFIG_HOME = ($env.home | path join "project" "config")
		$env.XDG_DATA_HOME = ($env.home | path join "project" "data")
		$env.XDG_CACHE_HOME = ($env.home | path join "project" "cache")

		$env.path = ($env.path | append ($env.home | path join "program" "starship"))
		$env.path = ($env.path | append ($env.home | path join "program" "zoxide"))
		$env.path = ($env.path | append ($env.home | path join "program" "fzf"))

		$env.LANG = "en_US.UTF-8"
		$env.LC_ALL = "en_US.UTF-8"

} else if ($nu.os-info.name == "linux") {
	echo "Running on Linux" 
} else if ($nu.os-info.name == "macos") {
	echo "Running on macOS"
} else {
	echo $"Running on ($nu.os-info.name)"
}

$env.config.buffer_editor = "nvim"
$env.config.show_banner = false


$env.STARSHIP_CONFIG = ($env.XDG_CONFIG_HOME | path join "starship.toml")
$env.STARSHIP_CACHE = $env.XDG_CACHE_HOME

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")


zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
source ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

alias cd = z
