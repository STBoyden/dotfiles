#!/usr/bin/env bash

if ! command -v git > /dev/null 2>&1; then
    echo "Git is required, please install \`git\`."
    exit 1
fi

if [[ -z $(find "$HOME/.ssh" -name "id_*.pub") ]]; then
    echo "Please set-up SSH authentication for Git."
    exit 1
fi

if [ -d "$HOME/.config/nvim/" ]; then
    echo "Please back-up your existing neovim configuration before continuing."
    exit 1
fi

# clone neovim configuration, and AstroNvim
git clone https://github.com/AstroNvim/AstroNvim    "$HOME/.config/nvim"
git clone git@github.com:STBoyden/astronvim-config  "$HOME/.config/nvim/lua/user"

git submodule update --recursive --remote # update all submodules

# add, commit and push any changes made to the submodules as of the current date
git add     -A
git commit  -m "Updated to latest submodules as of $(date --iso-8601=date)"
git push
