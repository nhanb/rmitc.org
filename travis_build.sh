#!/usr/bin/env bash
# This script is for use in travis-ci only.

# Generate site from markdown source
jekyll build

# Exit with appropriate exit code if jekyll failed
if [ $? != 0 ]; then exit $?; fi

# Only proceed to deployment if this is the master branch
if [ "$TRAVIS_BRANCH" != master ]; then exit 0; fi

# Make sure git will let us push
git config --global user.email "nhan.buithanh@rmitc.org"
git config --global user.name "travis"

# Clone existing production repo and change working dir to it
source_path=`pwd`  # store current working dir's path
production_path=$HOME/production
production_repo=https://${GH_TOKEN}@github.com/rmitc/rmitc.github.io.git
git clone $production_repo $production_path
cd $production_path

# Fetch ghp-import script (python FTW!)
wget https://raw.githubusercontent.com/nhanb/ghp-import/master/ghp-import
chmod +x ghp-import  # make it executable

# dump generated web files to master branch then push
#   -n: add .nojekyll file
#   -p: push to remote (origin)
#   -b: specify branch
#   -m: commit message
./ghp-import -p -n -b master -m "Build #$TRAVIS_BUILD_NUMBER"\
  $source_path/_site > /dev/null 2>&1
