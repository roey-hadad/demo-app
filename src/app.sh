#!/bin/bash
# Demo application - Real Time College, Jenkins Fundamentals 2026
set -euo pipefail

VERSION="@VERSION@"
BUILD="@BUILD@"

greet() {
  local name="${1:-world}"
  echo "hello, ${name}"
}

add() {
  echo $(( ${1:-0} + ${2:-0} ))
}

mul() {
  echo $(( ${1:-0} * ${2:-0} ))
}

case "${1:---greet}" in
  --version) echo "demo-app ${VERSION} (build ${BUILD})" ;;
  --add)     add "${2:-0}" "${3:-0}" ;;
  --mul)     mul "${2:-0}" "${3:-0}" ;;
  --greet)   greet "${2:-}" ;;
  *)         greet "${1}" ;;
esac
