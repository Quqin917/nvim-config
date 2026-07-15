#!/bin/bash

FOLDER="nvim-lazy"
DIR=$(dirname "$0")"/$FOLDER"
cd "$DIR" || exit

. ../scripts/functions.sh

if ! which nvim; then
  error "nvim is not downloaded yet."
  exit 5
fi

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/nvim)"

info "Settings up nvim..."

printf "SOURCE FILE:     \t\t %s\n" "$SOURCE"
printf "DESTINATION FILE:\t\t %s\n" "$DESTINATION"

substep_info "Creating nvim Config Folder"

if [ "$FOLDER" = "nvim-lazy" ]; then
  mkdir -vp "$DESTINATION/lua/packages"

  mkdir -vp "$DESTINATION/lua/packages/coding"
  mkdir -vp "$DESTINATION/lua/packages/interface"
  mkdir -vp "$DESTINATION/lua/packages/treesitter"
  mkdir -vp "$DESTINATION/lua/packages/editor"
  mkdir -vp "$DESTINATION/lua/packages/utils"
  mkdir -vp "$DESTINATION/lua/packages/extras"
fi

if [ "$FOLDER" = "nvim-bare" ]; then
  mkdir -vp "$DESTINATION/lua/quqin/core"
  mkdir -vp "$DESTINATION/lua/quqin/themes"
  mkdir -vp "$DESTINATION/lua/quqin/plugins"
  
  mkdir -vp "$DESTINATION/lua/quqin/plugins/lsp"
  mkdir -vp "$DESTINATION/lua/quqin/plugins/art"
  mkdir -vp "$DESTINATION/lua/quqin/plugins/completions"
  mkdir -vp "$DESTINATION/lua/quqin/plugins/ui"
fi

substep_info "Linking nvim Configuration..."
fd --hidden --type f --exclude setup.sh | while read -r fn; do
  symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clean_broken_symlink "$DESTINATION"
