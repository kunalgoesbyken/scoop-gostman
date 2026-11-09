#!/usr/bin/env bash
set -euo pipefail

repo=kunalgoesbyken/gostman
tag=$(gh release view --repo "$repo" --json tagName --jq .tagName)
version=${tag#v}
sums=$(gh release download "$tag" --repo "$repo" --pattern SHA256SUMS --output -)

sha() {
  local found
  found=$(awk -v name="$1" '$2 == name { print $1 }' <<<"$sums")
  [[ -n $found ]] || { echo "SHA256SUMS of $tag has no line for $1" >&2; exit 1; }
  echo "$found"
}

point() {
  local manifest=$1 asset=$2 suffix=${3:-}
  jq --indent 4 \
    --arg version "$version" \
    --arg url "https://github.com/$repo/releases/download/$tag/$asset$suffix" \
    --arg hash "$(sha "$asset")" \
    '.version = $version | .architecture."64bit".url = $url | .architecture."64bit".hash = $hash' \
    "$manifest" > "$manifest.next"
  mv "$manifest.next" "$manifest"
}

point bucket/gostman.json Gostman-windows-amd64-portable.exe "#/Gostman.exe"
point bucket/gostman-cli.json gostman-cli-windows-amd64.zip

echo "$version"
