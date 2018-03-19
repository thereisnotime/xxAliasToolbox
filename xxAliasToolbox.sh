#!/bin/bash
# HEREDOC string containing the aliases
# xxAliasToolbox
# Oneliner:
# cd /tmp && wget https://pastebin.com/raw/wk3rECd2 -O xxAliasToolbox.sh && sed -i 's/\r$//' xxAliasToolbox.sh && bash xxAliasToolbox.sh
################################
# Install dependencies
apt-get install -y curl psmisc wget locate whois htop

# Script to write
SCRIPTBASE=$(cat <<'END_HEREDOC'
#XXALIASTOOLBOX
##################
# xxAliasToolbox
# v2.6
##################
#### Custom
alias xxports='netstat -tulpn'
alias xxupdate='apt-get update && apt-get upgrade'
alias xxtools='apt-get -y install screen net-tools '
alias xxinterfaces='ip link'
alias xxtree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias xxservices='service --status-all'
alias xxflushservices='systemctl daemon-reload'
alias xxpfind='ps aux | grep '
alias xxffind='find / -name '
alias xxdfind='find / -type d -name '
alias xxpkill='kill -9 '
alias xxptree='pstree -a'
alias xxfoldersize="du -h --max-depth=1 | sort -rh"
alias xxneverhere="history -c && history -w"
alias xxusers="cut -d: -f1 /etc/passwd"
#### Shorteners
alias xxshells='cat /etc/shells'
alias c='clear'
alias h='history'
alias j='jobs -l'
alias xxbye="shutdown -h now 'Server is going down for upgrade. Please save your work.' -t 0"
#### Beautifiers
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias mount='mount |column -t'
alias df='df -H'
alias du='du -ch'
alias ls='ls -l --color=auto'
# Requires colordiff package
alias diff='colordiff'
#### Speeders
alias mkdir='mkdir -pv'
alias wget='wget -c'
#### Dyslexia
alias dc='cd'
alias sl='ls'
#### Functions
function xxwhois() {
whois=$2
if [ $# -eq 0 ] || [ $# -gt 2 ]; then
	echo '=== Usage:'
	echo 'To check with IANA: xxwhois DOMAIN to check in IANA.'
	echo 'To check with custom whois: xxwhois DOMAIN WHOIS'
	echo 'To check in preset whois: xxwhois DOMAIN PRESET'
	echo 'Available PRESET: enom, register, godaddy, name, pdr, verisign, noip, amazon.'
fi
if [ $# -eq 1 ]; then
	echo '=== Begin result from IANA.'
	echo $1 | nc whois.iana.org 43
	echo '=== End result from IANA.'
	return 1
fi
if [ $# -eq 2 ]; then
	if [ $whois = "enom" ]; then whois='whois.enom.com'; fi
	if [ $whois = "register" ]; then whois='whois.register.com'; fi
	if [ $whois = "godaddy" ]; then whois='whois.godaddy.com'; fi
	if [ $whois = "name" ]; then whois='whois.name.com'; fi
	if [ $whois = "pdr" ]; then whois='whois.PublicDomainRegistry.com'; fi
	if [ $whois = "verisign" ]; then whois='whois.verisign.com'; fi
	if [ $whois = "noip" ]; then whois='whois.no-ip.com'; fi
	if [ $whois = "amazon" ]; then whois='Whois.Registrar.Amazon.com'; fi
	echo "=== Begin result from $whois."
	echo $1 | nc $whois 43
	echo "=== End result from $whois."
	return 1
fi
}
#ENDXXALIASTOOLBOX
END_HEREDOC
)

# Detect if old version is there.
for RCFILE in `find ~/.*rc`; do
if grep -q "#XXALIASTOOLBOX" "$RCFILE"; then
# Remove old version
echo "Old version detected in: $RCFILE"
sed -i '/#XXALIASTOOLBOX/,/#ENDXXALIASTOOLBOX/g' "$RCFILE"
# Remove trailing lines
sed -i -e :a -e '/^\n*$/{$d;N;};/\n$/ba' "$RCFILE"
echo "Removed old version from $RCFILE."
fi
# Write new xxAliasToolbox version to file.
echo "$SCRIPTBASE" >> "$RCFILE"
# shellcheck disable=SC1090
source "$RCFILE"
echo "Script installed in: $RCFILE"
done
unset SCRIPTBASE RCFILE
exit 0
# END OF FILE