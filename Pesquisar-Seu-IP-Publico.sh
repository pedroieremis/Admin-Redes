#!/bin/bash


res=$(curl -s "https://ipinfo.io/json" | tr -d "{" | cut -d ":" -f 2 | head -n 2 | tr -d '"' | tr -d ' ' | tr -d ',' | tr -d '\n')

echo "Your Public IP is > $res"
