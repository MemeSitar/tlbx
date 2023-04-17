#!/bin/bash

ADDED_OR_MODIFIED=$(git status -s | grep -F -e "A  " -e "M  " | cut -c4-)

if [[ ! $ADDED_OR_MODIFIED ]]
then
    gum style --foreground 9 "Please add files to this commit."
    ./gadd.sh
else
    gum style "The following files are added: " --foreground 9 &&
    gum style "$ADDED_OR_MODIFIED" --margin="1 2" &&
    gum confirm "Do you want to add more files to this commit?"
    if [ $? -eq 0 ]; then
        ./gadd.sh
    fi
fi &&

SUMMARY=$(gum input --placeholder "Summary of this change" --char-limit=100) &&
DESCRIPTION=$(gum write --prompt="> " --header "Description:" --placeholder="(Ctrl+D to finish)") &&

gum confirm "Commit?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"