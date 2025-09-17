#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 {xor}Base64Encoded"
    exit 1
fi

# Remove the {xor} prefix
encoded="${1#\{xor\}}"

# Decode base64 input
decoded=$(echo "$encoded" | base64 -d 2>/dev/null)

if [ -z "$decoded" ]; then
    echo "invalid"
    exit 1
fi

# XOR key
key="WebASecureKey"
key_len=${#key}
decoded_len=${#decoded}

# XOR decode character by character
i=0
result=""
while [ $i -lt $decoded_len ]; do
    char=$(printf "%d" "'${decoded:$i:1}")
    key_char=$(printf "%d" "'${key:$((i % key_len)):1}")
    xor_val=$((char ^ key_char))
    result="${result}$(printf \\$(printf '%03o' "$xor_val"))"
    i=$((i + 1))
done

# Output the decoded result
echo "$result"
