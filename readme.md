# xxAliasToolbox

### Description ###
A collection of helpful shell aliases and functons. It can autoinstall on bash, zsh and every other shell which will be listed in "find ~/.*rc".

### Installation ###
Easy oneliner for installation:
```sh
wget https://github.com/thereisnotime/xxAliasToolbox/raw/master/xxAliasToolbox.sh -O /tmp/xxAliasToolbox.sh && chmod +x /tmp/xxAliasToolbox.sh && /tmp/xxAliasToolbox.sh && rm /tmp/xxAliasToolbox.sh
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