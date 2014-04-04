#!/usr/bin/env bash

# This script is for use in travis-ci only.
# Humans like you have no business here!

# Just kidding! Here's making sure git will let us push
git config --global user.email "nhan.buithanh@rmitc.org"
git config --global user.name "travis"

# Fetch ghp-import script (should have stuck with Pelican...)
wget https://raw.githubusercontent.com/davisp/ghp-import/master/ghp-import
chmod +x ghp-import  # make it executable
./ghp-import _site  # dump generated web files to gh-pages branch

# Push gh-pages branch from this repo to production repo's master branch.
# Pretty neat eh?
git push https://${GH_TOKEN}@github.com/rmitc/rmitc.github.io.git gh-pages:master
