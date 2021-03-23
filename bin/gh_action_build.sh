#!/usr/bin/env bash
#
# Build public assets and create a github release

set -eu
set -o pipefail

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_DIR="${SCRIPT_DIR}"/../

PROG=$(basename "$0")

# Prints a small usage help. This is called on `--help` and on parameter validation errors.
# Syntax follows http://docopt.org/.
usage() {
  cat <<EOF
${PROG} <page_repo_dir>
EOF
}

main() {
  if [[ "$*" =~ ^(-h|--help)$ ]]; then
    usage
    exit
  fi
  pushd "${REPO_DIR}" > /dev/null
  npm install hexo-cli -g
  npm install
  bin/build.sh
}

main "$@"
