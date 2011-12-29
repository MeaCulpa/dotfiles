#!/bin/env sh
cat autoexec.cfg | awk 'NF == 2 {system("cp "$2" ~/workspace/dotfiles/game/q3/")}'
