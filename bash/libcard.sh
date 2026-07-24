#!/bin/bash

# This script quickly copies my library card number to the clipboard so I can simply paste it into a login portal rather than type it out by hand, something that happened to me several times and was annoying enough that I made this.

echo -n '[LIBRARY CARD NUMBER]' | xclip -selection clipboard

# `notify-send` requires a notification daemon to be installed, but you can simply replace it with `echo` if you wish.
notify-send "Library card number copied to clipboard."