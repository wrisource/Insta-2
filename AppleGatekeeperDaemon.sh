#!/bin/sh
#* AppleGatekeeper
#+ chris.gerke@gmail.com
#+
#+ Description: Payload free. Disable Gatekeeper.
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

#+ LaunchDaemon (daemon because softwareupdate requires root)
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/GateKeeper" Label "com.chrisgerke.GateKeeper"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/GateKeeper" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/GateKeeper" ProgramArguments -array "/usr/sbin/spctl" "--master-disable"

#+ or like this if you want to do it once
#+ /usr/bin/defaults write /var/db/SystemPolicy-prefs enabled no

#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchDaemons/GateKeeper.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchDaemons/GateKeeper.plist" 

#+ Load if booted
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "" ]; then
 sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchDaemons/GateKeeper.plist"
fi

exit 0