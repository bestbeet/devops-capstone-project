#!/usr/bin/env bash
# Link the ten existing repository issues to GitHub Project #2.
# Requires GitHub CLI (gh), login, and the 'project' OAuth scope.
set -euo pipefail

OWNER="bestbeet"
PROJECT="2"
REPO="bestbeet/devops-capstone-project"

command -v gh >/dev/null || { echo "Install GitHub CLI: brew install gh"; exit 1; }
gh auth status >/dev/null || { echo "Run: gh auth login"; exit 1; }

for issue in $(seq 1 10); do
  url="https://github.com/$REPO/issues/$issue"
  echo "Adding $url to project $PROJECT"
  gh project item-add "$PROJECT" --owner "$OWNER" --url "$url" || echo "Please check if issue #$issue is already added"
done

echo
echo "Open: https://github.com/users/$OWNER/projects/$PROJECT/views/1"
echo "Set the board view, Status, Sprint and Estimate fields on GitHub."
echo "Capture each required screenshot BEFORE moving stories to the next status."
