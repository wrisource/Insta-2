#!/bin/sh
#* AppleSoftwareUpdate
#+ chris.gerke@gmail.com
#+
#+ Description: Payload free. Disable SoftwareUpdate scheduled check.
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
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleSoftwareUpdate" Label "com.cg.AppleSoftwareUpdate"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleSoftwareUpdate" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleSoftwareUpdate" ProgramArguments -array "/usr/sbin/softwareupdate" "--schedule" "off"

#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchDaemons/AppleSoftwareUpdate.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchDaemons/AppleSoftwareUpdate.plist" 

#+ Load if booted
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "" ]; then
 sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchDaemons/AppleSoftwareUpdate.plist"
fi

exit 0
