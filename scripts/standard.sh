#!/bin/bash

echo running the standard script

echo $FORK is a Standard site

# Clone the fork
if [ ! -z "$GITHUB_TOKEN" ]
then
    GITHUB_DOMAIN="https://$GITHUB_TOKEN@github.com"
else
    GITHUB_DOMAIN="https://github.com"
fi

 git clone $GITHUB_DOMAIN/$ORG/$FORK

# cd into the fork
cd $FORK

# Add the upstream
git remote add upstream "$GITHUB_DOMAIN/$ORG/$REPO.git"

# #list remotes
git remote -v

# Fetch the upstream
git fetch upstream

# Checkout the upstreams main branch
git checkout main

# Merge the upstream
git merge upstream/main || true

# # All files and globs listed in $NEVER_OVERWRITE will be kept as they are
for FILE in $NEVER_OVERWRITE; do
    if [ -f "$FILE" ]; then
        git checkout --ours $FILE
    else
        echo $FILE doesnt exist skipping
    fi
done

# # All files and globs listed in $ALWAYS_OVERWRITE will be overwritten by the upstream
for FILE in $ALWAYS_OVERWRITE; do
    if [ -f "$FILE" ]; then
        git checkout --theirs $FILE
    else
        echo $FILE doesnt exist skipping
    fi
done

# # List all the remaining conflicts
CONFLICTS=$(git diff --name-only --diff-filter=U)

#If there are conflicts, loop over them
for CONFLICT in $CONFLICTS; do
    echo we have a confict $CONFLICT
    # If the file is in $NEVER_OVERWRITE, skip it
    for FILE in $NEVER_OVERWRITE; do
        if [[ $CONFLICT == $FILE ]]; then
            echo $CONFLICT is in NEVER_OVERWRITE, skipping
            continue 2
        fi
    done
    echo $CONFLICT is not in NEVER_OVERWRITE, using upstream
    # Checkout the upstream version
    git checkout --theirs $CONFLICT
done

# #create a merge branch for the pr
git checkout -b "merge-$REF"

# # Commit the changes
git commit -am "Merge upstream" --allow-empty

# # Push the changes
git push --set-upstream origin "merge-$REF"

# # create a pr
echo "creating a PR for merge-$REF"
gh pr create --repo $GITHUB_DOMAIN/$ORG/$FORK --title "Merge upstream" --body "todo update this w template"

# echo "No conflicts auto merging pr"
# # auto merge if its a template
# # if gh api /repos/$ORG_NAME/$FORK/topics --jq ".names" | grep template; then
# gh pr merge "merge-$REF_NAME" --repo https://$GITHUB_TOKEN@github.com/$ORG_NAME/$FORK --squash
# # fi

# Go back to the parent repo
# cd .. && rm -rf $FORK

