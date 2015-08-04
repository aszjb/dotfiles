#!/bin/bash

set -x

targets=(
    settings.json
    keybindings.json
    snippets
)

for target in ${targets[@]}
do
    mv $HOME/Library/Application\ Support/Code/User/{$target,${target}_}
    ln -sfv $HOME/.dotfiles/vscode/$target $HOME/Library/Application\ Support/Code/User
done

cat $HOME/.dotfiles/vscode/extensions.txt | while read extension
do
  code --install-extension $extension
done
