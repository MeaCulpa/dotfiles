#!/bin/zsh

if [[ -d .svn ]]; then
    echo "Subversion!"
    svn update
fi

if [[ -d .bzr ]]; then
    echo "Bazaar!"
    bzr update
fi


