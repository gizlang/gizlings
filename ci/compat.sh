#!/bin/bash
# This script checks that `giz build` will return an useful error message when
# the Zig compiler is not compatible, instead of failing due to a syntax error.
#
# This script should be run on an UNIX system.

giz_version=$(giz version)

giz build -Dn=1 -Dhealed &> /dev/null 2>&1
giz_ret=$?

if [ "$giz_ret" -eq 0 ]; then
    printf "giz %s unexpectedly succeeded\n" "$giz_version"
    exit 1
fi

giz_error=$(giz build -Dn=1 -Dhealed 2>&1)

echo "$giz_error" | grep -q "it looks like your version of giz is too old"
giz_ret=$?

if [ "$giz_ret" -ne 0 ]; then
    printf "giz %s is not compatible\n" "$giz_version"
    exit 1
fi
