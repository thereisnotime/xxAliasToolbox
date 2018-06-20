#!/bin/bash
# HEREDOC string containing the aliases
# xxAliasToolbox
# Oneliner:
# curl -L https://github.com/thereisnotime/xxAliasToolbox/raw/master/xxAliasToolbox.sh | sh
################################
# Install dependencies
apt-get install -y curl psmisc wget locate whois htop net-tools screen jq xmlstarlet yamllint

# Script to write
SCRIPTBASE=$(cat <<'END_HEREDOC'
#XXALIASTOOLBOX
##################
# xxAliasToolbox
# v3.9
##################
#### Custom
alias xxports='netstat -tulpn'
alias xxupdate='apt-get update && apt-get upgrade'
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
alias xxutcdate='TZ=utc date'
alias xxmacs='ifconfig | grep -E `xxregxmac`'
alias xxips='ifconfig | grep -E `xxregxip`'
alias xxemptydirectory='rm * &> /dev/null;rm -rf * &> /dev/null'
alias xxupdateself='wget https://github.com/thereisnotime/xxAliasToolbox/raw/master/xxAliasToolbox.sh -O /tmp/xxAliasToolbox.sh && chmod +x /tmp/xxAliasToolbox.sh && /tmp/xxAliasToolbox.sh && rm /tmp/xxAliasToolbox.sh'
#### Validators
alias xxyamlcheck='yamllint '
alias xxjsoncheck='jq "." >/dev/null <'
alias xxxmlcheck='xmlstarlet val '
#### Characters
alias xxascii='man ascii | grep -m 1 -A 63 --color=never Oct'
alias xxalphabet='echo a b c d e f g h i j k l m n o p q r s t u v w x y z'
alias xxunicode='echo ✓ ™  ♪ ♫ ☃ ° Ɵ ∫'
alias xxnumalphabet='xxalphabet; echo 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6'
#### Regular Expressions
alias xxregxmac='echo [0-9a-f]{2}:[0-9a-f]'
alias xxregxip="echo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'"
alias xxregxemail='echo "[^[:space:]]+@[^[:space:]]+"'
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
alias mdkir='mkdir'
alias soruce='source'
alias souce='source'
#### Functions
function xxtouchsize(){
if [ $# -eq 0 ] || [ $# -gt 2 ]; then
	echo 'Creates dummy files with specified size.'
	echo 'Usage: xxtouchsize 200M TEMP.TXT'
	return 1	
fi
fallocate -l $1 $2
}
function xxurlencode() {
if [ $# -eq 0 ] || [ $# -gt 1 ]; then
	echo 'Usage: xxurlencode STRING'
	return 1	
fi
echo -ne $1 | hexdump -v -e '/1 "%02x"' | sed 's/\(..\)/%\1/g'
}
function xxurldecode() {
if [ $# -eq 0 ] || [ $# -gt 1 ]; then
	echo 'Usage: xxurlencode STRING'
	return 1	
fi
local url_encoded="${1//+/ }"
printf '%b' "${url_encoded//%/\\x}"
}
function xxhostname() {
if [ $# -eq 0 ] || [ $# -gt 1 ]; then
	echo "Current hostname is: $(hostname)"
	echo 'Usage: xxhostname NEWHOSTNAME'
	return 1	
fi
if [ $# -eq 1 ]; then
	NEWNAME=$1
	OLDNAME=$(hostname)
	sed -i "s/$OLDNAME/$NEWNAME/g" /etc/hosts
	sed -i "s/$OLDNAME/$NEWNAME/g" /etc/hostname
	/etc/init.d/hostname.sh start &> /dev/null
	invoke-rc.d hostname.sh start &> /dev/null
	hostnamectl set-hostname $NEWNAME &> /dev/null
	sysctl kernel.hostname=$NEWNAME &> /dev/null
	echo "After relogin, your new hostname will be $(echo $1)"
	return 1
fi
}
function xxgetmac() {
if [ $# -eq 0 ] || [ $# -gt 1 ]; then
	echo 'Usage: xxgetmac INTERFACE'
	return 1	
fi
if [ $# -eq 1 ]; then
	ip -o link show dev $1 | grep -Po 'ether \K[^ ]*'
	return 1
fi
}
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
eval "$SCRIPTBASE"
echo "Script installed in: $RCFILE"
done
unset SCRIPTBASE RCFILE
exit 0
# END OF FILE
