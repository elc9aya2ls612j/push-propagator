#!/bin/bash

echo $ORG is the org name
echo $REPO is the repo name
echo run as $USER_NAME $USER_EMAIL

git config --global user.name "$USER_NAME"
git config --global user.email "$USER_EMAIL"

mkdir parent
# checkout the parent repo
git clone https://$GITHUB_TOKEN@github.com/$ORG/$REPO.git parent