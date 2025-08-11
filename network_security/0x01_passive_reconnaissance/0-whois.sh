#!/bin/bash
whois $1 | awk '/^(Registrant|Admin|Tech)/ {gsub(/^[[:space:]]+|[[:space:]]+$/,"",$0); split($0,a,":"); gsub(/^ /,"",a[2]); gsub(/ /,"$",a[2]); print a[1]","a[2]}' 
