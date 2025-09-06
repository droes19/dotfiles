# Get a Node.js version from the official Node.js releases index.
#
# Options:
#   --lts (-l)             Get the latest LTS version (any alias).
#   --alias <name>         Get the latest LTS version by alias (e.g., "Gallium", "Iron").
#   --major <number>       Get the latest version matching a given major (e.g., "20").
#
# Examples:
#   get-node-version --lts
#   get-node-version --alias iron
#   get-node-version --major 18
#
def get-node-version [
  --lts (-l)
  --alias: string
  --major: string
] {
  let releases = (http get https://nodejs.org/dist/index.json)

  # Case 1: latest LTS version
  if $lts {
    let latest_lts_name = (
      $releases
      | where lts != false
      | get lts
      | uniq
      | get 0
    )

    return (
      $releases
      | where lts == $latest_lts_name
      | get 0.version
    )
  }

  # Case 2: LTS version by alias
  if ($alias | is-not-empty) {
    return (
      $releases
      | where lts != false
      | where ($it.lts | str downcase) == ($alias | str downcase)
      | get 0.version
    )
  }

  # Case 3: Latest version of a major (prepend "v" to match Node.js format)
  if ($major | is-not-empty) {
    let major_prefix = $"v($major)"
    return (
      $releases
      | where ($it.version | str starts-with $major_prefix)
      | get 0.version
    )
  }

  # Default: Latest stable version
  return (
    $releases
    | get 0.version
  )
}

# Select and activate a Node.js version installed under $NVM_DIR
def --env use_nvm_node [
  --lts (-l) # Latest LTS version
  --alias: string # LTS version by alias
  --major: string # Latest version of a given major
  --auto (-a) # Restore last used version (from current_version.txt)
] {
  if ($env.NVM_DIR? | is-empty) {
    error make {msg: "NVM_DIR is not set"}
  }

  mut version = ""

  if $auto {
    # Try to restore from saved file
    let save_path = ($env.NVM_DIR | path join "current_version.txt")
    if ($save_path | path exists) {
      $version = (open --raw $save_path)
    } else {
      # Fallback: try latest LTS *if installed*
      let lts_version = (get-node-version --lts)
      let nvm_bin_check = ($env.NVM_DIR | path join "versions" "node" $lts_version "bin")
      if ($nvm_bin_check | path exists) {
        $version = $lts_version
        # Save for future sessions
        $version | save --force $save_path
      } else {
        error make {msg: $"No saved Node version found and LTS ($lts_version) is not installed. Run 'nvm install --lts' first."}
      }
    }
  } else {
    # Explicit selection
    if $lts {
      $version = (get-node-version --lts)
    } else if ($alias | is-not-empty) {
      $version = (get-node-version --alias $alias)
    } else if ($major | is-not-empty) {
      $version = (get-node-version --major $major)
    } else {
      $version = (get-node-version)
    }

    # Save for next session
    let save_path = ($env.NVM_DIR | path join "current_version.txt")
    $version | save --force $save_path
  }

  # Path to selected Node.js bin
  let nvm_bin = ($env.NVM_DIR | path join "versions" "node" $version "bin")

  if not ($nvm_bin | path exists) {
    error make {msg: $"Node.js version ($version) is not installed under NVM_DIR. Try: nvm install $version"}
  }

  # Update PATH
  let current_nvm = ($env.PATH | where ($it | str starts-with $env.NVM_DIR) | get 0?)
  if ($current_nvm | is-not-empty) {
    path-replace $current_nvm $nvm_bin
  } else {
    path-prepend $nvm_bin
  }

  # Export current version for scripts/tools
  $env.NU_NODE_VERSION = $version
}

# Path utilities
def --env path-prepend [d: string] {
  $env.PATH = ($env.PATH | prepend $d)
}

def --env path-replace [old: string new: string] {
  $env.PATH = (
    $env.PATH | each {|p|
      if $p == $old { $new } else { $p }
    }
  )
}

def --env path-remove [d: string] {
  $env.PATH = (
    $env.PATH | where ($it != $d)
  )
}
