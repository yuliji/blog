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
  # local version=$1
  local latest # latest release
  local latest_date
  local latest_release # the release number of a day
  local today
  today="$(date +"%Y%m%d")"
  echo ${today}
  pushd "${REPO_DIR}" > /dev/null
  latest="$(gh release list -L 1 | awk '{print $1}')" # get the latest release
  latest_date="$(echo ${latest} | cut -d '-' -f 1)"
  latest_release="$(echo ${latest} | cut -d '-' -f 2)"

  echo ${latest_date} ${latest_release}
  if (( "${today}" == "${latest_date}" )); then
    echo "eq"
  fi
  # gh release create "${version}" ./dist/public.tar.gz -t '' -n ''
}

main "$@"
