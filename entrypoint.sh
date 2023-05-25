#!/bin/sh -l

GITHUB_TOKEN=$1
NEVER_OVERWRITE=$2
ALWAYS_OVERWRITE=$3
USER_NAME=$4
USER_EMAIL=$5
OWNER=$6
REPO=$7
REF=$8

echo $OWNER is the org name
echo $REPO is the repo name
echo $REF is the ref name
echo run as $USER_NAME $USER_EMAIL

