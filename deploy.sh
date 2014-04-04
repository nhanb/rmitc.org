#!/usr/bin/env bash

# This script is for use in travis-ci only.
# Humans like you have no business here!

git config credential.helper "store --file=~/credentials"
echo "https://${GH_TOKEN}:@github.com" > ~/credentials
git clone https://github.com/rmitc/rmitc.github.io.git ~/output
jekyll build --destination ~/output
cd ~/output
git add -A
git commit -m $TRAVIS_BUILD_NUMBER
git push -u origin master -f
