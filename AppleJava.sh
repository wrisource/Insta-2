#!/bin/sh
#* AppleJava
#+ chris.gerke@gmail.com
#+
#+ Description: Payload required. Stop disabling Java applet plugin and web start apps.
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

#* Detect payload & copy
if [ -r "${SCRIPT_DIR}/PAYLOAD" ]; then
 #+ TARGET_DIR
 sudo /bin/mkdir -p "${TARGET_DIR}/usr/local/bin"
 #+ Payload
 sudo /bin/cp -Rf "${SCRIPT_DIR}/PAYLOAD/" "${TARGET_DIR}/usr/local/bin"
fi

#+ Disable javadisabler LaunchAgent
sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/LaunchAgents/com.apple.javadisabler" "RunAtLoad" "No"
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/System/Library/LaunchAgents/com.apple.javadisabler.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/System/Library/LaunchAgents/com.apple.javadisabler.plist"

exit 0
