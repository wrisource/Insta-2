#!/bin/sh
#* AppleUserTemplate
#+ chris.gerke@gmail.com
#+
#+ Description: Payload free. Default Apple User Template preferences for 3rd Party Apps.
#+
#+ Version: 1.0
#+
#+ History:
#+     1.0: Script.
#+
#+ TODO:
#+     * Add more error checking?
#+     * Think about editing existing users?

ME=$0
SCRIPT_DIR="$1/Contents/Resources"
TARGET_DIR="$3"

#+ // fix
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

#+ Modify ${TARGET_DIR}/System/Library/User Template
for USER_TEMPLATE in `sudo ls ${TARGET_DIR}/System/Library/User\ Template`
do
 if [ -r "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences" ]; then
  #* com.adobe.crashreporter
  sudo /usr/bin/defaults write "/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.crashreporter" always_never_send -int 2
  #* com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10 dict" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10:AVGeneral dict" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10:AVGeneral:CheckForUpdatesAtStartup array" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10:AVGeneral:CheckForUpdatesAtStartup:0 integer 0" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Set :10:AVGeneral:CheckForUpdatesAtStartup:0 0" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10:AVGeneral:CheckForUpdatesAtStartup:1 bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Set :10:AVGeneral:CheckForUpdatesAtStartup:1 NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  #* Adobe Lightroom
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Lightroom2" noAutomaticallyCheckUpdates -bool true
  #* CyberDuck
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" connection.login.useKeychain -string false
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" donate.reminder -string 4.2.1
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" donate.reminder.date -string 1333064699726
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" SUCheckAtStartup -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" update.check -string FALSE
  #* Flip4Mac
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/net.telestream.wmv" UpdateCheck_CheckInterval -int 9999
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/net.telestream.wmv.plugin" ShowController -bool YES
  #* Growl
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlDisplayPluginName -string "Music Video"
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlEnabled -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlEnableForward -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlLoggingEnabled -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlMenuExtra -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlStartServer -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlUpdateCheck -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" StickyWhenAway -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" com.Growl.MusicVideo -dict
  sudo /usr/libexec/PlistBuddy -c "Add :com.Growl.MusicVideo dict" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  sudo /usr/libexec/PlistBuddy -c "Add :com.Growl.MusicVideo:Duration integer 0" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  sudo /usr/libexec/PlistBuddy -c "Set :com.Growl.MusicVideo:Duration 0" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  sudo /usr/libexec/PlistBuddy -c "Add :com.Growl.MusicVideo:Opacity integer 0" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  sudo /usr/libexec/PlistBuddy -c "Set :com.Growl.MusicVideo:Opacity 0" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  #* Microsoft Office
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.microsoft.autoupdate2" HowToCheck -string Manual
  #+ Stuffit Expander
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.stuffit.StuffIt-Expander" moveToApplicationsFolderAlertSuppress -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.stuffit.StuffIt-Expander" registrationAction -int 2
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.stuffit.StuffIt-Expander" SUEnableAutomaticChecks -bool NO
 fi
done

sudo /bin/mkdir -p "${TARGET_DIR}/Library/Application Support/Macromedia"
sudo /bin/echo "AutoUpdateDisable=1" > "${TARGET_DIR}/Library/Application Support/Macromedia/mms.cfg"
sudo /bin/echo "SilentAutoUpdateEnable=0" >> "${TARGET_DIR}/Library/Application Support/Macromedia/mms.cfg"

exit 0