#!/bin/bash
ps -u "$1" -o pid,comm,vsz,rss | grep -vE '^\s*PID|\s0\s*0$'
