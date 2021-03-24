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
  if [[ -n $(git status -s) ]]; then
    echo "Error: work treen is not clean"
    exit 1
  fi



  local head_commit
  local latest

  head_commit=$(git rev-parse --short HEAD)
  latest="$(gh release list -L 1 | awk '{print $1}')" # get the latest release

  if [[ "${latest}" == "${head_commit}" ]]; then
    echo "no new commit, quit without building..."
    exit 0
  fi

  pushd "${REPO_DIR}" > /dev/null
  node_modules/hexo-cli/bin/hexo clean
  node_modules/hexo-cli/bin/hexo generate
  rm -rf dist/public.tar.gz
  mkdir -p dist
  tar -czvf dist/public.tar.gz public
  gh release create "${head_commit}" ./dist/public.tar.gz -t '' -n ''
}

main "$@"
