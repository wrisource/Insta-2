#!/bin/sh
#* LoginHook
#+ chris.gerke@gmail.com
#+
#+ Description: Payload required.
#+
#+ Version: 1.0
#+
#+ History:
#+     1.0: Script.
#+
#+ TODO:
#+     * Add error checking?
#+     * LaunchDaemon instead?

ME=$0
SCRIPT_DIR="$1/Contents/Resources"
TARGET_DIR="$3"

#+ // fix
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

#* Detect payload copy, set loginhook
if [ -r "${SCRIPT_DIR}/PAYLOAD" ]; then
 #+ Payload
 sudo /bin/cp -Rf "${SCRIPT_DIR}/PAYLOAD/" "${TARGET_DIR}/Library/Scripts"
 sudo /bin/chmod -R 755 "${TARGET_DIR}/Library/Scripts/LoginHook.sh"
 sudo /usr/sbin/chown -R root:wheel "${TARGET_DIR}/Library/Scripts/LoginHook.bash"
 sudo /bin/chmod -R 755 "${TARGET_DIR}/Library/Scripts/LoginHook"
 sudo /usr/sbin/chown -R root:wheel "${TARGET_DIR}/Library/Scripts/LoginHook"
 #+ Loginhook
 sudo /usr/bin/defaults write "${TARGET_DIR}/var/root/Library/Preferences/com.apple.loginwindow" LoginHook -string "/Library/Scripts/LoginHook.bash"
fi

exit 0
