# Container image that runs your code
FROM alpine:3.10

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# create scripts directory
RUN mkdir /scripts

# Copy all the scripts
COPY scripts/build.sh /scripts/build.sh
COPY scripts/custom.sh /scripts/custom.sh
COPY scripts/standard.sh /scripts/standard.sh

# Install gh, curl, jq, bash, git, openssh
RUN apk add --no-cache curl jq bash git openssh github-cli

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]