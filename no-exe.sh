#!/usr/bin/env bash
FILES=$(git diff --staged --name-only --diff-filter=d)
OK=0
for FILE in $FILES; do
    if [[ -x $FILE ]]; then
        OK=1
        echo "$FILE is executable"
    fi
done

exit $OK
