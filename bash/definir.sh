#!/usr/bin/env bash

# Most of this was borrowed from "define" by BreadOnPenguins (https://github.com/BreadOnPenguins/scripts/blob/master/shortcuts-menus/define). My main modifications were to convert it into a Spanish CLI dictionary using the Real Academia Española API (https://rae-api.com/) and to print more definitions by default.

palabra=${1:-$(xclip -o -selection primary 2>/dev/null || wl-paste 2>/dev/null)}

# Check for empty word or special characters
[[ -z "$palabra" || "$palabra" =~ [\/] ]] && notify-send -h string:bgcolor:#bf616a -t 3000 "Invalid input." && exit 0

query=$(curl -s --connect-timeout 5 --max-time 10 "https://rae-api.com/api/words/$palabra")

# Check for connection error (curl exit status stored in $?)
[ $? -ne 0 ] && notify-send -h string:bgcolor:#bf616a -t 3000 "Connection error." && exit 1

# Check for invalid word response
[[ "$query" == *"NOT_FOUND"* ]] && notify-send -h string:bgcolor:#bf616a -t 3000 "Invalid word." && exit 0

# Show all definitions
def=$(echo "$query" | jq -r '.data.meanings[].senses[].raw')

# Requires a notification daemon to be installed
notify-send -t 60000 "$palabra -" "$def"


### MORE OPTIONS :)

# Show first definition for each part of speech (thanks @morgengabe1 on youtube)
# def=$(echo "$query" | jq -r '.[0].meanings[] | "\(.partOfSpeech): \(.definitions[0].definition)\n"')

# Regex + grep for just definition, if anyone prefers that to jq
# def=$(grep -Po '"definition":"\K(.*?)(?=")' <<< "$query")

bold=$(tput bold) # Print text bold with echo, for visual clarity
normal=$(tput sgr0) # Reset text to normal
echo -e "${bold}Definición de \"$palabra\" (via la Real Academia Española https://rae-api.com/):\n"
echo "${normal}$def"
