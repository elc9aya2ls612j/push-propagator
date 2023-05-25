#!/bin/bash

echo $ORG is the org name
echo $REPO is the repo name
echo $REF is the ref name
echo run as $USER_NAME $USER_EMAIL

git config --global user.name "$USER"
git config --global user.email "$USER"

mkdir parent
# checkout the parent repo
git clone https://$GITHUB_TOKEN@github.com/$OWNER/$REPO.git parent