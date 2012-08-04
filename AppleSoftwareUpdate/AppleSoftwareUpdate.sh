#!/bin/sh
#* AppleSoftwareUpdate
#+ chris.gerke@gmail.com
#+
#+ Description: Payload required. Disable SoftwareUpdate scheduled check.
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
 #+ Target
 sudo /bin/mkdir -p "${TARGET_DIR}/usr/local/bin"
 #+ Payload
 sudo /bin/cp -Rf "${SCRIPT_DIR}/PAYLOAD/" "${TARGET_DIR}/usr/local/bin"
 #+ Permissions
 sudo /bin/chmod u+s "${TARGET_DIR}/usr/local/bin/susoff"
 #+ Permissions
 sudo /bin/chmod u+s "${TARGET_DIR}/usr/local/bin/suson"
fi

#+ LaunchDaemon (daemon because softwareupdate requires root)
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/SoftwareUpdate" Label "com.chrisgerke.SoftwareUpdate"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/SoftwareUpdate" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/SoftwareUpdate" ProgramArguments -array "/usr/sbin/softwareupdate" "--schedule" "off"

#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchDaemons/SoftwareUpdate.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchDaemons/SoftwareUpdate.plist" 

#+ Load Daemon
sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchDaemons/SoftwareUpdate.plist"

exit 0
