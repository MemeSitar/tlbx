#!/bin/bash

FILES=$(gum choose $(git status -s | grep -vF -e "A  " -e "M  " | cut -c4-) --no-limit)

if [[ ! $FILES ]]
then
    gum style "No files were added." --foreground 9 &&
    exit 1
else 
    git add "$FILES" 
    gum style "The following files are added: " --foreground 10
    ADDED_OR_MODIFIED=$(git status -s | grep -F -e "A  " -e "M  " | cut -c4-)
    gum style "$ADDED_OR_MODIFIED" --margin="0 2"
fi


# git status -s | grep -F "??" | cut -c4- # shows untracked files
# git status -s | grep -vF -e "A  " -e "M  " | cut -c4- # shows edited AND untracked files
# git status -s | grep -F "A  " | cut -c4- # shows only added files
# using ! $FILES helps very much!! use !!!!