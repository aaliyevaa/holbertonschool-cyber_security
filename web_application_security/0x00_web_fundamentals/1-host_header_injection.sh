#!/bin/bash
curl -s -X POST "$2" -H "Host: $1" -H "Content-Type: application/x-www-form-urlencoded" -d "$3" -i
