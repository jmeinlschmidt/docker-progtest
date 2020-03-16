#!/bin/bash
set -e

printf "\n\033[0;44m---> Starting the SSH server.\033[0m\n"
 
service ssh start
service ssh status

# Prevent host system to stop docker if no action is provided
tail -f /dev/null
