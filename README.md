# xxAliasToolbox

### Description ###
A collection of helpful shell aliases and functons. It can autoinstall on bash, zsh and every other shell which will be listed in "find ~/.*rc".

### Installation ###
* WARNING: The current public version of the script installs the aliases and the functions in all *.rc files in your current ~ folder. It should not create any problems, but if it does - please open an issue here.

Easy oneliner for installation with wget:
```sh
wget https://github.com/thereisnotime/xxAliasToolbox/raw/master/xxAliasToolbox.sh -O /tmp/xxAliasToolbox.sh && chmod +x /tmp/xxAliasToolbox.sh && /tmp/xxAliasToolbox.sh && rm /tmp/xxAliasToolbox.sh
``` 

Easy oneliner for installation with curl:
```sh
curl -L https://github.com/thereisnotime/xxAliasToolbox/raw/master/xxAliasToolbox.sh | sh
``` 

### Dependencies ###
Currently the script depends only on the package manager and few internals, which get installed with the script:
```sh
curl
psmisc
wget
locate
whois
htop
net-tools
screen
jq
xmlstarlet
yamllint
pv
dtrx
````

### Compatability ###
The should work on most Linus distributions and has been tested on the following:
```sh
Debian 7 x64
Debian 7 x86
Debian 8 x64
Debian 8 x86
Debian 9 x64
``` 

### Uninstall ###
To remove xxAliasToolbox from all shells use:
```sh
for RCFILE in `find ~/.*rc`; do
if grep -q "#XXALIASTOOLBOX" "$RCFILE"; then
	sed -i '/#XXALIASTOOLBOX/,/#ENDXXALIASTOOLBOX/g' "$RCFILE"
fi
done
```
After that you can clear your environment variables and source ~/.*rc files or just exit and login again.
