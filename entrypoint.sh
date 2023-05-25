#!/bin/sh -l

GITHUB_TOKEN=$1
NEVER_OVERWRITE=$2
ALWAYS_OVERWRITE=$3
USER_NAME=$4
USER_EMAIL=$5
OWNER=$6
REPO=$7
REF=$8

echo "Token $1"
echo "Never Overwrite $2"
echo "Always Overwrite $3"
time=$(date)
echo "time=$time" >> $GITHUB_OUTPUT