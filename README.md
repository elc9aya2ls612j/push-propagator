# push-propagator

Push Propagator is a GitHub action that will help you keep a repository's forks (in the same organization) in sync with the upstream repository. If you are dealing with an application that uses GitHub repositories as the main handle for configurations, then `push-propagator` will aid you in keeping a large amount of similar configurations in sync.

It support specifying files that should always be overwritten, files that should never be propagated. For all other files, a PR will be created in case of a conflict, asking the forked repository to incorporate the upstream changes.
