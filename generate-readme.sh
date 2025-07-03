#!/bin/bash

set -e

GITHUB_REPOSITORY="${GITHUB_REPOSITORY:-wimwenigerkind/homebrew-tab}"
FORMULA_DIR="Formula"
README="README.md"
REPO_URL="https://github.com/${GITHUB_REPOSITORY}"

echo "# Homebrew Tap" > "$README"
echo "" >> "$README"
echo "## Packages" >> "$README"
echo "" >> "$README"
echo "| Package | Description | License | Formula | Repo | Install |" >> "$README"
echo "|-------|---------------|--------|---------|------|--------------|" >> "$README"

for file in "$FORMULA_DIR"/*.rb; do
  NAME=$(grep -E "^class " "$file" | awk '{print $2}')
  DESC=$(grep -E "^  desc " "$file" | sed 's/^  desc "\(.*\)"/\1/')
  HOMEPAGE=$(grep -E "^  homepage " "$file" | sed 's/^  homepage "\(.*\)"/\1/')
  LICENSE=$(grep -E "^  license " "$file" | sed 's/^  license "\(.*\)"/\1/')
  INSTALL_NAME=$(basename "$file" .rb)
  FORMULA_FILE_URL="$REPO_URL/blob/main/$file"

  INSTALL_CMD="\`brew install ${GITHUB_REPOSITORY#*/}/$INSTALL_NAME\`"

  echo "| $NAME | $DESC | $LICENSE | [Formula]($FORMULA_FILE_URL) | [Repo]($HOMEPAGE) | $INSTALL_CMD |" >> "$README"
done