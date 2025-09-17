#!/bin/bash

if [ "$1" = "" ]; then
    echo "Usage: $0 {xor}Base64Encoded"
    exit 1
fi

encoded="${1#\{xor\}}"

decoded=$(echo "$encoded" | base64 -d 2>/dev/null)

if [ "$decoded" = "" ]; then
    echo "invalid"
    exit 1
fi

key="WebASecureKey"
keylen=${#key}
i=0
output=""

while [ $i -lt ${#decoded} ]; do
    d_char=$(printf "%d" "'$(printf '%s' "$decoded" | cut -b $((i + 1)))")
    k_char=$(printf "%d" "'${key:$((i % keylen)):1}")
    xor=$((d_char ^ k_char))
    output="${output}$(printf \\$(printf '%03o' $xor))"
    i=$((i + 1))
done

echo "$output"

