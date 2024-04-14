latest_version="$(git tag | tail -1)"
echo 0
is_major="$(git log $latest_version..HEAD --oneline | cut -d ' ' -f2 | grep '!:' -c)"
is_minor="$(git log $latest_version..HEAD --oneline | cut -d ' ' -f2 | grep 'feat:' -c)"
echo 1

increment='patch'
echo 2

if ! [ "$is_major" = '0' ]; then
  echo 2.1
  increment='major'
else
  if ! [ "$is_minor" = '0' ]; then
    echo 2.2
    increment='minor'
  fi
fi
echo 3

npm i
version="$(npm run semver $latest_version -i $increment | tail -1)"
echo 4

echo "changes=<<EOFn" >>$GITHUB_OUTPUT
git log $latest_version..HEAD --oneline >>$GITHUB_OUTPUT
echo "EOFn" >>$GITHUB_OUTPUT
echo 5
echo "semver=$version" >>$GITHUB_OUTPUT
echo 6
