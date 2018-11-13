#!/bin/bash
set -e
set -o pipefail
set -x

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

if [[ -z "$GITHUB_REPOSITORY" ]]; then
	echo "Set the GITHUB_REPOSITORY env variable."
	exit 1
fi

URI=https://api.github.com
API_VERSION=v3
API_HEADER="Accept: application/vnd.github.${API_VERSION}+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

# Validate the GitHub token.
curl -o /dev/null -sSL -H "${AUTH_HEADER}" -H "${API_HEADER}" "${URI}/repos/${GITHUB_REPOSITORY}" || { echo "Error: Invalid repo, token or network issue!";  exit 1; }

# Get the check run action.
action=$(jq --raw-output .action "$GITHUB_EVENT_PATH")

# If it's not completed return early.
if [[ "$action" != "completed" ]]; then
	# Return early we only care about completed.
	echo "Check run has action: $action"
	echo "Want: completed"
	exit 0
fi

# Get the check run conclusion.
conclusion=$(jq --raw-output .check_run.conclusion "$GITHUB_EVENT_PATH")

# If it's not a failure return early.
if [[ "$conclusion" != "failure" ]]; then
	# Return early we only care about failure.
	echo "Check run has conclusion: $conclusion"
	echo "Want: failure"
	exit 0
fi

# Get the pull requests that goes with this check run.
pull_requests=( $(jq --raw-output .check_run.check_suite.pull_requests "$GITHUB_EVENT_PATH") )

# If we have no pull requests, return early.
if [ ${#pull_requests[@]} -eq 0 ]; then
	echo "Pull requests length is 0"
	exit 0
fi

# Iterate over the pull requests and post the comment.
for pr in ${pull_requests[@]}; do
	echo "Adding comment to PR: $pr"
done
