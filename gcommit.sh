#!/bin/bash

ADDED_OR_MODIFIED=$(git status -s | grep -F -e "A  " -e "M  " | cut -c4-)

if [[ ! $ADDED_OR_MODIFIED ]]
then
    gum style --foreground 9 "Please add files to this commit."
    ./gadd.sh
else
    gum style "The following files are added: " --foreground 10 &&
    gum style "$ADDED_OR_MODIFIED" --margin="0 2" &&
    EDITED_OR_UNTRACKED=$(git status -s | grep -vF -e "A  " -e "M  " | cut -c4-) &&
    if [[ $EDITED_OR_UNTRACKED ]]
    then
        gum confirm "Do you want to add more files to this commit?"
        if [ $? -eq 0 ]; then
            ./gadd.sh
        fi
    fi
fi &&

SUMMARY=$(gum input --placeholder "Summary of this change" --char-limit=100) &&
gum style "SUMMARY: $SUMMARY" --margin "1 1" --bold &&
DESCRIPTION=$(gum write --prompt="> " --header "Description:" --placeholder="(Ctrl+D to finish)") &&
gum style "DESCRIPTION: $DESCRIPTION" --margin "1 1" --italic &&

gum confirm "Commit?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"