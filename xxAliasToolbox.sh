#!/bin/bash
# HEREDOC string containing the aliases
# xxAliasToolbox
# Oneliner:
# cd /tmp && wget https://pastebin.com/raw/5qhGr9FS -O xxAliasToolbox.sh && sed -i 's/\r$//' xxAliasToolbox.sh && bash xxAliasToolbox.sh
################################
SCRIPTFILE="${HOME}/.bashrc"
SCRIPTBASE=$(cat <<'END_HEREDOC'
#XXALIASTOOLBOX
##################
# xxAliasToolbox
# v2.2
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
if grep -q "#XXALIASTOOLBOX" "$SCRIPTFILE"; then
# Remove old function and trailing empty lines
echo 'Old version detected.'
sed -i '/#XXALIASTOOLBOX/,/#ENDXXALIASTOOLBOX/g' "$SCRIPTFILE"
sed -i -e :a -e '/^\n*$/{$d;N;};/\n$/ba' "$SCRIPTFILE"
echo 'Removed old version.'
fi
# Write new function
echo "$SCRIPTBASE" >> "$SCRIPTFILE"
# shellcheck disable=SC1090
source "$SCRIPTFILE"
unset SCRIPTBASE SCRIPTFILE
echo 'Script installed in ~/.bashrc'
exit 0
# END OF FILE