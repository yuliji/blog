#!/usr/bin/env bash
#
# This script does this and that.

set -eu
set -o pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="${SCRIPT_DIR}"/../

PROG=$(basename "$0")

# Prints a small usage help. This is called on `--help` and on parameter validation errors.
# Syntax follows http://docopt.org/.
usage() {
  cat <<EOF
${PROG} <release_version>
EOF
}

main() {
  local version=$1
  pushd "${REPO_DIR}"
  gh release create "${version}" ./dist/public.tar.gz -t '' -n ''
}

main "$@"
