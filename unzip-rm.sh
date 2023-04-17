#!/bin/sh
if [ $(ls | grep -F ".zip" | wc -l ) -ne "0" ]; then
    unzip *.zip
    rm *.zip
else
    echo "There are no files to unzip!"
fi
