$env.config = {
  show_banner: false
  ls: {
    use_ls_colors: true
    clickable_links: true
  }
  edit_mode: vi
}

if (which nvim | is-not-empty) {
  $env.EDITOR = "nvim"
  alias vim = nvim
}

source ($nu.data-dir | path join "vendor" "autoload" "zoxide.nu")
alias cd = z

def install_topiary_nushell [] {
  if (($env.XDG_CONFIG_HOME | path join topiary) | path exists) {
    print "already installed"
    return
  }
  git clone https://github.com/blindFS/topiary-nushell ($env.XDG_CONFIG_HOME | path join topiary)
}

source ($nu.default-config-dir | path join "custom" "nvm.nu")
use_nvm_node -a

