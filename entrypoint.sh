#!/bin/sh -l

echo "Token $1"
echo "Never Overwrite $2"
echo "Always Overwrite $3"
time=$(date)
echo "time=$time" >> $GITHUB_OUTPUT