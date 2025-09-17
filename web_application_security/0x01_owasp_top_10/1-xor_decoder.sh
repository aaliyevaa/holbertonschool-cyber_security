#!/bin/bash

# Check if the argument is provided
if [ -z "$1" ]; then
  echo "Usage: ./1-xor_decoder.sh {xor}encoded_string"
  exit 1
fi

# Remove the {xor} prefix
encoded=$(echo "$1" | sed 's/{xor}//')

# Base64 decode into raw binary
decoded=$(echo "$encoded" | base64 -d 2>/dev/null)

# Check if base64 decoding succeeded
if [ $? -ne 0 ]; then
  echo "Error: Invalid Base64 input."
  exit 1
fi

# XOR key
key=95

# Use a while-read loop to process binary data byte-by-byte
# Use `xxd -p` to get hex dump of decoded binary
output=""
while IFS= read -r -n2 hex; do
  # Convert hex to decimal
  byte=$((16#$hex))
  # XOR with the key
  xor_byte=$((byte ^ key))
  # Append to output
  output+=$(printf "\\x%02x" "$xor_byte")
done < <(echo -n "$decoded" | xxd -p -c1)

# Output the final decoded message
echo -ne "$output"

