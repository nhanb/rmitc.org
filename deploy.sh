#!/usr/bin/env bash

# This script is for use in travis-ci only.
# Humans like you have no business here!

$credentials_path=$HOME/credentials
git config credential.helper "store --file=$credentials_path"
echo "https://${GH_TOKEN}@github.com" > $credentials_path
git config --global user.email "nhan.buithanh@rmitc.org"
git config --global user.name "travis"

site_path=$HOME/rmitc_site
git clone https://github.com/rmitc/rmitc.github.io.git $site_path
jekyll build --destination $site_path
cd ~/output
git add -A
git commit -m $TRAVIS_BUILD_NUMBER
git push -u origin master -f
