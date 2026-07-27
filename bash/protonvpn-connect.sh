#!/bin/bash

# Script for automating credential input and connection to ProtonVPN via OpenVPN on the command line as an alternative to the ProtonVPN app.
# It then runs ProtonVPN in the background, allowing you to close the window and end the terminal session while remaining connected.

# The script must be run as sudo.
# If you try to run it first then enter sudo credentials, it will not work as intended.
if [[ $EUID -ne 0 ]]; then
    echo "Run with sudo: sudo $0"
    exit 1
fi

# Nohup allows the process to continue running after the terminal session ends, and disown removes it from the shell's 
# job table so it won't be killed when the terminal session ends.
# You also need to create a file /etc/openvpn/proton/auth.txt with your ProtonVPN username on the first line and
# your password on the second line. Make sure to chmod 600 that file for best security practices.
nohup sudo openvpn --config [/PATH/TO/CONFIGFILE].protonvpn.udp.ovpn --auth-user-pass /etc/openvpn/proton/auth.txt --auth-nocache > /tmp/protonvpn.log 2>&1 & disown

# For myself, I simply send the output to a /tmp/ file because this is for personal use and I don't particularly care about these logs.
# If you want to see the logs, use `tail -f /tmp/protonvpn.log`.
# I also use a bash alias called `proton-cleanup` (`alias proton-cleanup="sudo pkill openvpn; sudo rm -f /tmp/protonvpn.log"`)
# that I always use to disconnect, because if you don't remove the log file it will cause errors next time.
sudo chown [USER]:[USER] /tmp/protonvpn.log
echo "ProtonVPN launched in background, PID $!. Logs: /tmp/protonvpn.log"
