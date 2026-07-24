### These are some aliases that I find useful to append to my .bashrc file. Some are merely flipped to their Windows counterparts when I find the Windows version of the command to be more intuitive to type, since I was a Windows user for years before switching to Linux.

```
alias cls="clear"
alias sau="sudo apt update"
alias sauu="sudo apt update && sudo apt upgrade -y"
alias sai="sudo apt install"
alias py="python3"
alias myip="curl https://icanhazip.com/"
alias proton-cleanup="sudo pkill openvpn; sudo rm -f /tmp/protonvpn.log" (See my protonvpn-connect.sh script for context)
```

### The following one only applies to other users of TryHackMe who connect to the site via VPN.

```
alias thmvpn="sudo openvpn \[/PATH/TO/TryHackMe/CONFIGFILE\].ovpn"
```