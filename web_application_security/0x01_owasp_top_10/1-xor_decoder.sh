#!/bin/bash

# Check if argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 {xor}Base64EncodedString"
    exit 1
fi

# Extract base64 part (remove {xor} prefix)
input="${1#\{xor\}}"

# Decode base64
decoded=$(echo "$input" | base64 -d 2>/dev/null)
if [ $? -ne 0 ]; then
    echo "Invalid base64 string"
    exit 1
fi

# XOR key (used in WebSphere)
key="WebASecureKey"
key_length=${#key}

# Perform XOR decoding
output=""
for (( i=0; i<${#decoded}; i++ )); do
    c=${decoded:i:1}
    k=${key:i % key_length:1}
    xor=$(printf "%d" "'$c")
    key_byte=$(printf "%d" "'$k")
    result=$(( xor ^ key_byte ))
    output+=$(printf "\\x%02x" "$result")
done

# Print the decoded result
echo -e "$output"
