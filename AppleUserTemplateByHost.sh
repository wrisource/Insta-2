#!/bin/sh
#* AppleUserTemplateByHost
#+ chris.gerke@gmail.com
#+
#+ Description: Payload required. Default Apple User Template ByHost preferences.
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

SCREENSAVER="Default.slideSaver"

#+ // fix
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

TARGET_OS=$(sudo /usr/bin/defaults read "${TARGET_DIR}/System/Library/CoreServices/SystemVersion" ProductVersion)

#* Detect payload & copy
if [ -r "${SCRIPT_DIR}/PAYLOAD" ]; then
 #+ TARGET_DIR
 sudo /bin/mkdir -p "${TARGET_DIR}/usr/local/bin"
 #+ Payload
 sudo /bin/cp -Rf "${SCRIPT_DIR}/PAYLOAD/AppleMenuExtrasRunOnce" "${TARGET_DIR}/usr/local/bin/AppleMenuExtrasRunOnce"
 #+ Payload
 sudo /bin/cp -Rf "${SCRIPT_DIR}/PAYLOAD/AppleMultiTouchRunOnce" "${TARGET_DIR}/usr/local/bin/AppleMultiTouchRunOnce"
 #+ Payload
 sudo /bin/cp -Rf "${SCRIPT_DIR}/PAYLOAD/AppleScreenSaverRunOnce" "${TARGET_DIR}/usr/local/bin/AppleScreenSaverRunOnce"
 #+ Payload, redundant once fully 10.8
 sudo /bin/cp -Rf "${SCRIPT_DIR}/PAYLOAD/Screensavers/${SCREENSAVER}" "${TARGET_DIR}/Library/Screen Savers/${SCREENSAVER}"
fi

#+ LaunchDaemon
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleMenuExtras" Label "com.cg.AppleMenuExtras"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleMenuExtras" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleMenuExtras" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/AppleMenuExtrasRunOnce"
#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchDaemons/AppleMenuExtras.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchDaemons/AppleMenuExtras.plist" 
#+ Load if booted
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "" ]; then
 sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchDaemons/AppleMenuExtras.plist"
fi

#+ LaunchDaemon
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleMultiTouchRunOnce" Label "com.cg.AppleMultiTouchRunOnce"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleMultiTouchRunOnce" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleMultiTouchRunOnce" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/AppleMultiTouchRunOnce"
#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchDaemons/AppleMultiTouchRunOnce.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchDaemons/AppleMultiTouchRunOnce.plist" 
#+ Load if booted
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "" ]; then
 sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchDaemons/AppleMultiTouchRunOnce.plist"
fi

#+ LaunchDaemon
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleScreenSaver" Label "com.cg.AppleScreenSaver"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleScreenSaver" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleScreenSaver" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/AppleScreenSaverRunOnce"
#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchDaemons/AppleScreenSaver.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchDaemons/AppleScreenSaver.plist" 
#+ Load if booted
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "" ]; then
 sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchDaemons/AppleScreenSaver.plist"
fi

exit 0