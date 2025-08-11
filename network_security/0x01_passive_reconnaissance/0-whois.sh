#!/bin/bash
whois $1 | awk -F': ' '/^(Registrant|Admin|Tech)/{sub(/^[ \t]+/,"");gsub(/: /,",");gsub(/[ \t]+/," ");sub(/,$/,"");print}'
