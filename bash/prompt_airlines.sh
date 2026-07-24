#!/bin/bash

# Quick script for sending a list of prompts to the Prompt Airlines CTF by Wiz (https://promptairlines.com/). Requires a prompts.txt list of line-separated prompts, and a session cookie which you can obtain through the devtools or however you like to get your cookies.

cat ./prompts.txt |
while read prompt; do
    echo "Sending prompt \"$prompt\"...";
    echo -n "Response: "
    curl -s -X POST \
      -d "{\"prompt\":\"$prompt\"}" \
      -H 'Content-Type: application/json' \
      -H 'Referer: https://promptairlines.com/' \
      -b "challenge_started=true; session=[PASTE YOUR COOKIE HERE]" \
      https://promptairlines.com/chat | jq '.content';
done