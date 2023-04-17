#!/bin/sh
grep -vE '^#' packages.txt | xargs sudo apt install -y
