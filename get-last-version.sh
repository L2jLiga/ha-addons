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

npm i
version=$(npm run semver "$latest_version" -i "$increment" | tail -1)

{
  echo "semver=$version"
  echo "changes<<EOF"
  git log "$latest_version"..HEAD --oneline
  echo "EOF"
} >>"$GITHUB_OUTPUT"

cat "$GITHUB_OUTPUT"
