#!/usr/bin/env zsh

# Env Vars
#   PLUGIN_NAME = YouCompleteMe
#   PLUGIN_DIR = /_vim/bundle/$PLUGIN_NAME

if [[ ! -d $PLUGIN_DIR ]]; then
  echo "ERROR: Unable to change to $PLUGIN_DIR" >&2
  exit 1
fi

set -e -x

cd $PLUGIN_DIR && ./install.py

