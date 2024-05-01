#!/usr/bin/bash

latest_version=$(git tag | tail -1)

is_major=$(git log "$latest_version"..HEAD --oneline | cut -d ' ' -f2 | grep '!:' -c)
is_minor=$(git log "$latest_version"..HEAD --oneline | cut -d ' ' -f2 | grep 'feat:' -c)

increment='patch'

if ! [ "$is_major" = '0' ]; then
  increment='major'
else
  if ! [ "$is_minor" = '0' ]; then
    increment='minor'
  fi
fi

version=$(npx -y semver "$latest_version" -i "$increment" | tail -1)

{
  echo "semver=$version"
  echo "changes<<EOF"
  git log "$latest_version"..HEAD --pretty=format:"<details><summary>%h %s</summary>%n%B</details>"
  echo "EOF"
} >>"$GITHUB_OUTPUT"
