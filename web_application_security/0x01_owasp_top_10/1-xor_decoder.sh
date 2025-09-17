#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 {xor}Base64Encoded"
    exit 1
fi

input="${1#\{xor\}}"
decoded=$(echo "$input" | base64 -d 2>/dev/null | xxd -p -c 256)

if [ -z "$decoded" ]; then
    echo "invalid"
    exit 1
fi

key="WebASecureKey"
keylen=${#key}
i=0
output=""

while [ $i -lt $((${#decoded} / 2)) ]; do
    hex_byte="${decoded:$((i * 2)):2}"
    byte=$((16#$hex_byte))
    k=$(printf "%d" "'${key:$((i % keylen)):1}")
    xor=$((byte ^ k))
    output="$output$(printf '\\x%02x' $xor)"
    i=$((i + 1))
done

echo -e "$output"

