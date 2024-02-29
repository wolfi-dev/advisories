#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

repo=$1

get_prs() {
    gh search prs --repo="${repo}" --author="octo-sts[bot]" --review=none --state=open --limit=50 --head=adv --sort=created --order=asc --json number --jq '.[].number'
}

readarray -t PRS < <(get_prs)
for pr in "${PRS[@]}"; do
  echo ">>> Enabling auto merge PR: ${pr}"

  # Attempt to enable auto merge PR
  GITHUB_TOKEN="${GH_TOKEN}" gh pr merge --squash --auto \
  --repo="${repo}" "${pr}"

done
