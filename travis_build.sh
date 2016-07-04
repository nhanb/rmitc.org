#!/usr/bin/env bash
# This script is for use in travis-ci only.

# Abort script as soon as an error happens
set -e

# Generate site from markdown source
# http://stackoverflow.com/questions/28611513/travis-build-failing-on-jekyll-project-cannot-find-jekyll
bundle exec jekyll build

# Only proceed to deployment if this is the master branch
# and not a pull request
if [ "$TRAVIS_BRANCH" != master ] || [ "$TRAVIS_PULL_REQUEST" != false ]; then
    echo "Jekyll build finished successfully. Your mom should be proud."
    exit 0
fi

echo "This is the master branch. Starting deployment..."

# Make sure git will let us push
git config --global user.email "nhan.buithanh@rmitc.org"
git config --global user.name "travis"

source_path=`pwd`  # store current working dir's path
production_path=$HOME/production
production_repo=https://${GH_TOKEN}@github.com/rmitc/rmitc.github.io.git

# Attempt to clone existing production repo
git clone $production_repo $production_path


echo "Production repo successfully cloned. Deploying..."
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
    $source_path/_site
