#!/bin/bash
set -e
set -o pipefail

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "You must have a GITHUB_TOKEN variable."
	exit 1
fi
