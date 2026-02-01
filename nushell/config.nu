source ($nu.default-config-dir | path join "themes" "catppuccin_mocha.nu")
$env.config = {
  show_banner: false
  buffer_editor : "nvim"
  ls: {
    use_ls_colors: true
    clickable_links: true
  }
  rm: {
    always_trash: false
  }
  table: {
    mode: rounded
    index_mode: always
    show_empty: true
    padding: {left: 1 right: 1}
    trim: {
      methodology: wrapping
      wrapping_try_keep_words: true
      truncating_suffix: "..."
    }
    header_on_separator: false
  }
  history: {
    max_size: 100_000
    sync_on_enter: true
    file_format: "sqlite"
    isolation: true
  }
  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "prefix"
    external: {
      enable: true
      max_results: 100
      completer: null
    }
    use_ls_colors: true
  }
  edit_mode: vi
}

if (which nvim | is-not-empty) {
  $env.EDITOR = "nvim"
  alias vim = nvim
}

if (which z | is-not-empty) {
  source ($nu.data-dir | path join "vendor" "autoload" "zoxide.nu")
  alias cd = z
}

def install_zoxide [] {
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
}

def install_topiary_nushell [] {
  if (($env.XDG_CONFIG_HOME | path join topiary) | path exists) {
    print "already installed"
    return
  }
  git clone https://github.com/blindFS/topiary-nushell ($env.XDG_CONFIG_HOME | path join topiary)
}

source ($nu.default-config-dir | path join "custom" "nvm.nu")
use_nvm_node -a

let ori_path = $env.PATH

def --env switch-java [version: string] {
  let java_paths = {
    # "8": "C:\\Program Files\\Java\\jdk1.8.0_301\\bin"
    # "21": "C:\\Projects\\Program\\graalvm-jdk-21\\bin"
  }
  if ($java_paths | get $version | is-empty) {
    print $"Java version ($version) not found"
  } else {
    $env.path = [($java_paths | get $version)] ++ $ori_path
  }
}
