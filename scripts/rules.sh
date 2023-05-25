#!/bin/bash

NEVER_OVERWRITE=$(cat $SCRIPTS_PATH/never_overwrite.txt |tr "\n" " ")
ALWAYS_OVERWRITE=$(cat $SCRIPTS_PATH/always_overwrite.txt |tr "\n" " ")
