#!/bin/bash

if [ "$1" = "" ]; then
    echo "Usage: $0 {xor}Base64Encoded"
    exit 1
fi

input="${1#\{xor\}}"
decoded=$(echo "$input" | base64 -d 2>/dev/null)

if [ "$?" -ne 0 ] || [ -z "$decoded" ]; then
    echo "invalid"
    exit 1
fi

key="WebASecureKey"
keylen=${#key}
out=""
i=0

while [ $i -lt "${#decoded}" ]; do
    d=$(printf "%d" "'$(printf '%s' "$decoded" | dd bs=1 count=1 skip=$i 2>/dev/null)'")
    k=$(printf "%d" "'${key:$((i % keylen)):1}")
    xor=$((d ^ k))
    out="${out}$(printf '\\x%02x' $xor)"
    i=$((i + 1))
done

echo -e "$out"
