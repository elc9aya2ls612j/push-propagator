#!/bin/bash

[ ! -z "$GITHUB_REPOSITORY" ] || source ./vars.sh

ORG_NAME=$(echo $GITHUB_REPOSITORY | cut -d / -f 1)
REPO_NAME=$(echo $GITHUB_REPOSITORY | cut -d / -f 2)
REF_NAME=$(git rev-parse --short HEAD)
echo $ORG_NAME is the org name
echo $REPO_NAME is the repo name
echo $REF_NAME is the ref name
echo run as $USER_NAME $USER_EMAIL

git config --global user.name "$USER_NAME"
git config --global user.email "$USER_EMAIL"

echo getting all the forks for $ORG_NAME/$REPO_NAME
FORKS=$(gh repo list $ORG_NAME --json parent,name -q '.[] | select(.parent != null and .parent.name == "'$REPO_NAME'") | .name')

# Loop through the forks
for FORK in $FORKS; do
    echo $FORK is the current fork
    # if the fork is a custom
    if gh api /repos/$ORG_NAME/$FORK/topics --jq ".names" | grep -q custom; then
        source $SCRIPTS_PATH/custom.sh
    else
        source $SCRIPTS_PATH/standard.sh
    fi
done