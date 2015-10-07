#!/usr/bin/env zsh

set -e

CWD="$(cd "$(dirname "$0")" && pwd)"
PLUGINS_FILE="$CWD/plugins"
BUNDLE_DIR="$CWD/_vim/bundle"

NAME=$0

function _pr_header {
  echo "~~~~~" $@ "~~~~~"
}

function _pr_error {
  echo "ERROR:" $@ >&2
}

function _pr_note {
  echo "NOTE:" $@
}

function _pr_usage {
  echo "Usage of $NAME"
  echo "  list                           -- list known plugins"
  echo "      (-v)                          \\- (optional) include commit hash and clone url"
  echo "  install                        -- install plugins. One of the following options required"
  echo "      -a                            |- all of the currently uninstalled plugins"
  echo "      name                          \\- only the known plugin"
  echo "  add name git-url               -- add and install the named plugin"
  echo "      [hash]                        \\- (optional) at the specified commit hash (master otherwise)"
  echo "  edit                           -- edit the 'plugins' file manually"
}

function _list {
  is_verbose=$1

  if [[ -s $PLUGINS_FILE ]]; then
    cat "$PLUGINS_FILE" | while IFS=, read plugin_name clone_url commit; do
      if [[ -d "$BUNDLE_DIR/$plugin_name" ]]; then
        echo -n "* "
      else
        echo -n "  "
      fi
      echo $plugin_name

      if [[ "-v" = "$is_verbose" ]]; then
        echo "      $commit - $clone_url"
      fi
    done
  else
    echo "No current plugins defined"
  fi
}

function _install_checkout {
  plugin_name=$1
  clone_url=$2
  commit=$3

  if [ -z "$clone_url" ]; then
    _pr_error "Must provide a clone_url"; exit 1
  fi

  cd "$BUNDLE_DIR"
  _pr_header "Cloning $plugin_name from $clone_url"
  git clone "$clone_url" "$plugin_name"

  cd "$BUNDLE_DIR/$plugin_name"
  _pr_header "Checking out commit $commit"
  git checkout -q "$commit"
}

function _install_one {
  plugin_name=$1

  if [[ -z "$plugin_name" ]]; then
    _pr_error "Must provide plugin-name"; _pr_usage; exit 1
  fi

  plugin_dir="$BUNDLE_DIR/$plugin_name"
  if [ -d "$plugin_dir" ]; then
    _pr_note "$plugin_name already installed at $plugin_dir"; exit 0
  fi

  if known_plugin_line=`grep "^$plugin_name," $PLUGINS_FILE` ; then
    # already know about it
    _pr_header "loading known plugin"

    echo "$known_plugin_line" | IFS=, read plugin_name clone_url commit

    if [ -z "$commit" ]; then
      _pr_note "commit not provided; defaulting to 'master'"
      commit="master"
    fi

    _install_checkout "$plugin_name" "$clone_url" "$commit"
  else
    _pr_error "Unknown plugin '$plugin_name'. Try adding it first."; exit 1
  fi
}

function _install_all {
  if [[ -s $PLUGINS_FILE ]]; then
    cat "$PLUGINS_FILE" | while IFS=, read plugin_name clone_url commit; do
      echo -n $plugin_name
      if [[ -d "$BUNDLE_DIR/$plugin_name" ]]; then
        echo " - (already installed)"
      else
        if output="$(_install_one $plugin_name 2>&1)"; then
          echo " - INSTALLED"
          echo "$output" | sed -e 's/^/    /'
        else
          echo " - ERROR"
          echo "$output" | sed -e 's/^/    /' >&2
          exit 1
        fi
      fi

    done
  else
    _pr_note "No plugins defined"
  fi
}

function _install {
  plugin_name=$1
  clone_url=$2
  commit=$3

  case $1 in
    ("")
      _pr_error "Must provide plugin-name"; _pr_usage; exit 1
      ;;
    ("-a")
      _install_all
      ;;
    (*)
      _install_one $1
      ;;
  esac
}

function _add_update_plugins_file {
  plugin_name=$1
  clone_url=$2

  cd "$BUNDLE_DIR/$plugin_name"
  current_commit="$(git rev-parse HEAD)"

  _pr_header "updating plugins file with commit info"
  echo "$plugin_name,$clone_url,$current_commit" >> $PLUGINS_FILE

  # sorting helps prevent merge conflicts"
  _pr_header "sorting plugins file"
  sort -o $PLUGINS_FILE $PLUGINS_FILE
}

function _add {
  plugin_name=$1
  clone_url=$2
  commit=$3

  if [[ -z "$plugin_name" ]]; then
    _pr_error "Must provide plugin-name"; _pr_usage; exit 1
  fi

  if [ -z "$clone_url" ]; then
    _pr_error "must provide a git-url"; _pr_usage; exit 1
  fi

  if known_plugin_line=`grep "^$plugin_name," $PLUGINS_FILE` ; then
    _pr_error "$plugin_name already recorded"; exit 1
  else

    plugin_dir="$BUNDLE_DIR/$plugin_name"
    if [ -d "$plugin_dir" ]; then
      _pr_note "$plugin_name already installed at $plugin_dir"; exit 0
    fi

    if [ -z "$commit" ]; then
      _pr_note "commit not provided; defaulting to 'master'"
      commit="master"
    fi

    _install_checkout "$plugin_name" "$clone_url" "$commit"

    _add_update_plugins_file "$plugin_name" "$clone_url"
  fi

}

function _edit {
  if [[ -z "$EDITOR" ]]; then
    EDITOR=vim
  fi

  $EDITOR $PLUGINS_FILE

  _pr_header "Plugins file update. Listing plugins"
  _list
}

case $1 in
  ("")
    _pr_usage; exit 0
    ;;
  (list)
    shift
    _list $@
    exit 0
    ;;
  (install)
    shift
    _install $@
    exit 0
    ;;
  (add)
    shift
    _add $@
    exit 0
    ;;
  (edit)
    _edit
    exit 0
    ;;
  (*)
    _pr_error "Unknown args: $*":
    _pr_usage; exit 1
    ;;
esac

