#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && echo -e "${RED}ERROR: this script should be sourced, not run${NC}" >&2 && exit 1

unset PIPEFY_OAUTH_TOKEN
echo "INFO: Removed credential environment variables"
