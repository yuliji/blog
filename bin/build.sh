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
${PROG} <page_repo_dir>
EOF
}

main() {
  local page_dir=$1
  if [[ "$*" =~ ^(-h|--help)$ ]]; then
    usage
    exit
  fi

  pushd "${SCRIPT_DIR}"/../
  hexo clean
  hexo generate
  rsync -v -a --delete --exclude .git "${REPO_DIR}"/public/ "${page_dir}"
  >&2 echo "synced to ${page_dir}"
  local head_commit
  head_commit=$(git rev-parse --short HEAD)
  pushd "${page_dir}"
  git add .
  git commit -am "sync ${head_commit}"
  git push
}

main "$@"
