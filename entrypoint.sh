#!/bin/sh -l

GITHUB_TOKEN=$1
NEVER_OVERWRITE=$2
ALWAYS_OVERWRITE=$3
USER_NAME=$4
USER_EMAIL=$5
ORG=$(echo $GITHUB_REPOSITORY | cut -d / -f 1)
REPO=$(echo $GITHUB_REPOSITORY | cut -d / -f 2)
REF=$8

echo ENV VARS
env

echo GitHub CLI version
which gh
gh --version

echo $GITHUB_TOKEN | gh auth login --with-token
gh auth status

source /scripts/build.sh

cd parent
FORKS=$(gh repo list $ORG --json parent,name -q '.[] | select(.parent != null and .parent.name == "'$REPO'") | .name')
echo "We have these forks: $FORKS"

# Loop through the forks
for FORK in $FORKS; do
    echo $FORK is the current fork
    # if the fork is a custom
    if gh api /repos/$ORG/$FORK/topics --jq ".names" | grep -q custom; then
        source /scripts/custom.sh
    else
        source /scripts/standard.sh
    fi
done