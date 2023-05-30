#!/bin/sh -l

GITHUB_TOKEN=$1
NEVER_OVERWRITE=$2
ALWAYS_OVERWRITE=$3
USER_NAME=$4
USER_EMAIL=$5
ORG=$(echo $GITHUB_REPOSITORY | cut -d / -f 1)
REPO=$(echo $GITHUB_REPOSITORY | cut -d / -f 2)

git config --global user.name "$USER_NAME"
git config --global user.email "$USER_EMAIL"

mkdir parent

# checkout the parent repo
git clone https://$GITHUB_TOKEN@github.com/$ORG/$REPO.git parent

cd parent

REF=$(git rev-parse --short HEAD)

cd ../

echo the token is $GITHUB_TOKEN
echo $ORG is the org name
echo $REPO is the repo name
echo run as $USER_NAME $USER_EMAIL
echo $REF is the ref name

#auth into GitHub CLI
echo $GITHUB_TOKEN | gh auth login --with-token
gh auth status

FORKS=$(gh repo list $ORG --fork --json parent,name -q '.[] | select(.parent != null and .parent.name == "'$REPO'") | .name')

# Loop through the forks
for FORK in $FORKS; do
    source /scripts/update.sh
done