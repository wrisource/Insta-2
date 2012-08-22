#!/bin/sh
#* AppleUserLibrary
#+ chris.gerke@gmail.com
#+
#+ Description: Payload free. Unhide ~/Library.
#+
#+ Version: 1.0
#+
#+ History:
#+     1.0: Script.
#+
#+ TODO:
#+     * Add error checking?

ME=$0
SCRIPT_DIR="$1/Contents/Resources"
TARGET_DIR="$3"

#+ // fix
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

#+ LaunchAgent
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchAgents/AppleUserLibrary" Label "com.cg.AppleUserLibrary"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchAgents/AppleUserLibrary" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchAgents/AppleUserLibrary" ProgramArguments -array "/bin/sh" "-c" "/bin/sleep 10; /usr/bin/chflags nohidden ~/Library"

#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchAgents/AppleUserLibrary.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchAgents/AppleUserLibrary.plist"

#+ Load if booted
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "" ]; then
 sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchAgents/AppleUserLibrary.plist"
fi

exit 0
