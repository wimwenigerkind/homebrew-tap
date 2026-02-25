#!/bin/bash

set -e

GITHUB_REPOSITORY="${GITHUB_REPOSITORY:-wimwenigerkind/homebrew-tab}"
FORMULA_DIR="Formula"
CASKS_DIR="Casks"
README="README.md"
REPO_URL="https://github.com/${GITHUB_REPOSITORY}"

echo "# Homebrew Tap" >"$README"
echo "" >>"$README"
echo "## Packages" >>"$README"
echo "" >>"$README"
echo "| Package | Description | License | Type | Repo | Install |" >>"$README"
echo "|-------|---------------|--------|---------|------|--------------|" >>"$README"

for file in "$CASKS_DIR"/*.rb; do
  NAME=$(grep -E "^  name " "$file" | sed 's/^  name "\(.*\)"/\1/')
  DESC=$(grep -E "^  desc " "$file" | sed 's/^  desc "\(.*\)"/\1/')
  HOMEPAGE=$(grep -E "^  homepage " "$file" | sed 's/^  homepage "\(.*\)"/\1/')
  LICENSE=$(grep -E "^  license " "$file" | sed 's/^  license "\(.*\)"/\1/')
  INSTALL_NAME=$(basename "$file" .rb)
  FILE_URL="$REPO_URL/blob/main/$file"

  INSTALL_CMD="\`brew install --cask wimwenigerkind/tab/$INSTALL_NAME\`"

  echo "| $NAME | $DESC | $LICENSE | [Cask]($FILE_URL) | [Repo]($HOMEPAGE) | $INSTALL_CMD |" >>"$README"
done

for file in "$FORMULA_DIR"/*.rb; do
  NAME=$(grep -E "^class " "$file" | awk '{print $2}')
  DESC=$(grep -E "^  desc " "$file" | sed 's/^  desc "\(.*\)"/\1/')
  HOMEPAGE=$(grep -E "^  homepage " "$file" | sed 's/^  homepage "\(.*\)"/\1/')
  LICENSE=$(grep -E "^  license " "$file" | sed 's/^  license "\(.*\)"/\1/')
  INSTALL_NAME=$(basename "$file" .rb)
  FILE_URL="$REPO_URL/blob/main/$file"

  INSTALL_CMD="\`brew install wimwenigerkind/tab/$INSTALL_NAME\`"

  echo "| $NAME | $DESC | $LICENSE | [Formula]($FILE_URL) | [Repo]($HOMEPAGE) | $INSTALL_CMD |" >>"$README"
done
