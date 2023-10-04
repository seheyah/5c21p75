####### panda.sh
### AUTHOR:     seheyah
### CREATION:   2023/10/04

### DATE: 20xx/xx/xx
### UPDATE:

echo '\n🐰 Following the whire rabbit...' 
echo '\n> Going to the user workspace'
#echo '\tClear zsh history'
#rm -f ~/.zsh_history
echo '\tClear Mail logs'
rm -rf ~/Library/Containers/com.apple.mail/Data/Library/Logs/Mail/*
echo '\tClear Safari cached blobs, URLs and timestamps'
rm -f ~/Library/Caches/com.apple.Safari/Cache.db
echo '\tClear Safari cookies'
rm -f ~/Library/Cookies/Cookies.binarycookies

echo '\n> Going to the system'
a=$(du -sh /private/var/db/diagnostics/ | awk '{ print $1 }')
#b=$(du -sh /var/db/diagnostics/ | awk '{ print $1 }')
echo '\tClear diagnostics logs: $a'
sudo rm -rf /private/var/db/diagnostics/*
sudo rm -rf /var/db/diagnostics/*

echo '\tClear shared-cache strings data'
#sudo rm -rfv /private/var/db/uuidtext/
#sudo rm -rfv /var/db/uuidtext/

echo '\tClear all system logs'
sudo rm -rf /var/log/*
echo '\tClear Apple System Logs (ASL)'
sudo rm -rf /private/var/log/asl/*
sudo rm -rf /var/log/asl/*
sudo rm -f /var/log/asl.log
sudo rm -f /var/log/asl.db
echo '\tClear CUPS printer job cache'
sudo rm -rf /var/spool/cups/c0*
sudo rm -rf /var/spool/cups/tmp/*
sudo rm -rf /var/spool/cups/cache/job.cache*
echo '\tClear DNS cache'
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
echo '\tClear install logs'
sudo rm -f /var/log/install.log
echo '\tClear system application logs'
sudo rm -rf /Library/Logs/*
echo '\tClear system cache files'
sudo rm -rf /Library/Caches/* &>/dev/null
sudo rm -rf /System/Library/Caches/* &>/dev/null
sudo rm -rf ~/Library/Caches/* &>/dev/null

echo '\tPurge inactive memory'
sudo purge

echo '\nHardening time '
echo '\tDisable AirDrop file sharing'
defaults write com.apple.NetworkBrowser DisableAirDrop -bool true
echo '\tDisable Bonjour multicast advertising'
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true
echo '\tDisable insecure telnet protocol'
sudo launchctl disable system/com.apple.telnetd
echo '\tDisable insecure TFTP service'
sudo launchctl disable 'system/com.apple.tftpd'
echo '\tDisable printing from any address including the Internet'
cupsctl --no-remote-any
#echo '\tDisable Remote Apple Events'
#sudo systemsetup -setremoteappleevents off
#echo '\tDisable remote login (incoming SSH and SFTP connections)'
#echo 'yes' | sudo systemsetup -setremotelogin off
echo '\tDisable remote printer administration'
cupsctl --no-remote-admin
echo '\tDisable sharing of local printers with other computers'
cupsctl --no-share-printers
#echo '\tDisables Guest access to file shares over AF'
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO
echo '\tDisables Guest access to file shares over SMB'
sudo defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
echo '\tDisables signing in as Guest from the login screen'
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool NO
echo '\tDo not show recent items on dock'
defaults write com.apple.dock show-recents -bool false

echo '\nShoot the 🐼'
echo 'Press any key to exit.\n'
read -n 1 -s

####### END
