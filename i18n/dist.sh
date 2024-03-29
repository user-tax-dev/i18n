#!/usr/bin/env bash

_DIR=$(
cd "$(dirname "$0")"
pwd
)

cd $_DIR

set -ex

version=$(cat package.json | jq -r '.version')

./build.sh &
wait

add() {
  git add -u
  git commit -m v$version || true
}

add

git pull

#npm set unsafe-perm true
npm version patch
add
git push
npm publish --access=public
