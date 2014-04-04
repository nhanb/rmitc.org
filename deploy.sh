#!/usr/bin/env bash

# This script is for use in travis-ci only.
# Humans like you have no business here!

git config credential.helper "store --file=~/credentials"
echo "https://${GH_TOKEN}:@github.com" > ~/credentials
git config --global user.email "nhan.buithanh@rmitc.org"
git config --global user.name "travis"

git clone https://github.com/rmitc/rmitc.github.io.git ~/output
jekyll build --destination ~/output
cd ~/output
git add -A
git commit -m $TRAVIS_BUILD_NUMBER
git push -u origin master -f
