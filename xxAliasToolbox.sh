#!/bin/bash
# HEREDOC string containing the aliases
# xxAliasToolbox
# Oneliner:
# cd /tmp && wget https://pastebin.com/raw/95JFgH2S -O xxAliasToolbox.sh && sed -i 's/\r$//' xxAliasToolbox.sh && bash xxAliasToolbox.sh
################################
SCRIPTBASE=$(cat <<'END_HEREDOC'
#XXALIASTOOLBOX
##################
# xxAliasToolbox
# v2.3
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
alias xxpkill='kill -9 '
alias xxfoldersize="du -h --max-depth=1 | sort -rh"
alias xxneverhere="history -c && history -w"
#### Shorteners
alias xxshells='cat /etc/shells'
alias c='clear'
alias h='history'
alias j='jobs -l'
alias xxbye="shutdown -h now 'Server is going down for upgrade. Please save your work.'"
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
#ENDXXALIASTOOLBOX
END_HEREDOC
)

# Detect if old version is there.
for RCFILE in `find ~/.*rc`; do
    if grep -q "#XXALIASTOOLBOX" "$RCFILE"; then
		# Remove old version and trailing empty lines.
		echo "Old version detected in: $RCFILE"
		sed -i '/#XXALIASTOOLBOX/,/#ENDXXALIASTOOLBOX/g' "$RCFILE"
		sed -i -e :a -e '/^\n*$/{$d;N;};/\n$/ba' "$RCFILE"
		echo "Removed old version from $RCFILE."
	fi
	# Write new xxAliasToolbox version to file.
	echo "$SCRIPTBASE" >> "$RCFILE"
	# shellcheck disable=SC1090
	source "$RCFILE"
	echo "Script installed in: $RCFILE"
done
unset SCRIPTBASE SCRIPTFILE
exit 0
# END OF FILE