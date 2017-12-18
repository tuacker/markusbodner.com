#!/bin/bash

# Helper to print echo messages in bold
function bold_echo() {
  echo -e "\033[1m$1\033[0m"
}

# Check presence of arguments
if [ -z "$1" ]
  then
    bold_echo "===> Repo name not supplied."
    bold_echo "===> Usage: ./script.sh <reponame>"
    exit 1;
fi

set -eu; set -o pipefail

REPO=$1
REMOTE="https://gitlab.com/tuacker/$1"
DIRECTORY=~/$REPO/
DEST_DIR=/srv/www/$REPO/

if [ ! -d "$DIRECTORY" ]; then
  bold_echo "===> Creating $DIRECTORY"
  mkdir $DIRECTORY
fi

if [ ! -d "$DIRECTORY/.git/" ]; then
  bold_echo "===> No repo found, cloning into $REMOTE"
  git clone --depth 1 $REMOTE $DIRECTORY
  echo
else
  bold_echo "===> Pulling latest changes from $REMOTE"
  (cd $DIRECTORY && git pull)
  echo
fi

bold_echo "===> Switching to directory: $DIRECTORY"
cd $DIRECTORY


bold_echo "===> Generating site with hugo"
hugo
echo

bold_echo "===> Deploying new site to $DEST_DIR"
sudo rsync -ah --delete ${DIRECTORY%%/}/public/ $DEST_DIR


bold_echo "===> Setting correct owner to $DEST_DIR (www-data:www-data)"
sudo chown -R www-data:www-data $DEST_DIR


bold_echo "===> Cleaning up $DIRECTORY (remove public/ folder)"
rm -rf ${DIRECTORY%%/}/public/

echo
bold_echo "===> Done. New page available at https://$REPO"
