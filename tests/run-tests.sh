#!/bin/bash
# Tiny test harness that emits JUnit XML, so Jenkins' junit step has something real to read.
# Set FAIL_TESTS=true to make one test fail on purpose (demonstrates UNSTABLE / yellow).
set -uo pipefail

APP="${APP:-dist/app.sh}"
OUT="reports"
mkdir -p "$OUT"

pass=0; fail=0; cases=""

check() {                       # check <name> <expected> <actual>
  local name="$1" expected="$2" actual="$3"
  if [ "$expected" = "$actual" ]; then
    pass=$((pass+1))
    cases="${cases}    <testcase classname=\"demo-app\" name=\"${name}\" time=\"0.01\"/>
"
    echo "  PASS  ${name}"
  else
    fail=$((fail+1))
    cases="${cases}    <testcase classname=\"demo-app\" name=\"${name}\" time=\"0.01\">
      <failure message=\"expected '${expected}' but got '${actual}'\">assertion failed</failure>
    </testcase>
"
    echo "  FAIL  ${name}: expected '${expected}' got '${actual}'"
  fi
}

echo "running tests against ${APP}"

check "greet_default"  "hello, world"  "$("$APP" --greet)"
check "greet_name"     "hello, jenkins" "$("$APP" --greet jenkins)"
check "add_numbers"    "7"             "$("$APP" --add 3 4)"
check "mul_numbers"    "12"            "$("$APP" --mul 3 4)"

if [ "${FAIL_TESTS:-false}" = "true" ]; then
  check "add_numbers_broken" "99" "$("$APP" --add 1 1)"
fi

total=$((pass+fail))
cat > "$OUT/junit.xml" <<XML
<?xml version="1.0" encoding="UTF-8"?>
<testsuites>
  <testsuite name="demo-app" tests="${total}" failures="${fail}" errors="0" time="0.05">
${cases}  </testsuite>
</testsuites>
XML

echo "----------------------------------------"
echo "${pass} passed, ${fail} failed  ->  ${OUT}/junit.xml"

# Exit 0 even on failure: the junit step turns failures into UNSTABLE (yellow),
# which is exactly the distinction taught on slide 27.
exit 0
