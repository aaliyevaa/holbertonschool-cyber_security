#!/bin/bash
whois $1 | awk '/^(Registrant|Admin|Tech)/ {gsub(/^[ \t]+|[ \t]+$/, "", $0); split($0,a,":"); gsub(/^ /,"",a[2]); print a[1]","a[2]}' > $1.csv
