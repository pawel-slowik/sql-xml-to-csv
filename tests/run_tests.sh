#!/bin/bash

passed=0
failed=0
exit_status=1

for test_case in tests/*; do
	input="$test_case/input.xml"
	expected="$test_case/expected.csv"
	if [[ ! -a "$input" || ! -a "$expected" ]]; then
		continue
	fi
	parameters=()
	if [[ -a "$test_case/parameters.sh" ]]; then
		source "$test_case/parameters.sh"
	fi

	echo -n "$test_case... "
	diff_output=$(xsltproc "${parameters[@]}" xml2csv.xslt - < "$input" | diff -u "$expected" -)
	diff_status=$?

	if [[ $diff_status -eq 0 ]]; then
		passed=$(($passed + 1))
		echo "passed"
		continue
	fi

	failed=$(($failed + 1))
	echo "failed"
	echo "$diff_output"
done

if [[ $failed -eq 0 ]]; then
	exit_status=0
fi

echo "passed: $passed, failed: $failed"
exit $exit_status
