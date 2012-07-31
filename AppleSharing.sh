#!/bin/sh
#* AppleSharing
#+ chris.gerke@gmail.com
#+
#+ Description: Payload required. VNC Password, Apple Remote Assistance, MOTD banner, SSH Daemon.
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

MOTD=$(sudo /usr/bin/defaults read "${SCRIPT_DIR}/config" MOTD)
VNCPASSWD=$(sudo /usr/bin/defaults read "${SCRIPT_DIR}/config" VNCPASSWD)

#+ // fix
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

#+ MOTD Banner
sudo /bin/echo " " > "${TARGET_DIR}/etc/motd"
sudo /bin/echo "${MOTD}" >> "${TARGET_DIR}/etc/motd"
sudo /bin/echo " " >> "${TARGET_DIR}/etc/motd"

#+ VNC Password
sudo /bin/echo "${VNCPASSWD}" > "${TARGET_DIR}/Library/Preferences/com.apple.VNCSettings.txt"

#+ VNC Permissions
sudo /usr/sbin/chown -R root:wheel "${TARGET_DIR}/Library/Preferences/com.apple.VNCSettings.txt"
sudo /bin/chmod -R 600 "${TARGET_DIR}/Library/Preferences/com.apple.VNCSettings.txt"

#* Detect payload & copy
if [ -r "${SCRIPT_DIR}/PAYLOAD" ]; then
 #+ Target
 sudo /bin/mkdir -p "${TARGET_DIR}/usr/local/bin"
 #+ Payload
 sudo /bin/cp -Rf "${SCRIPT_DIR}/PAYLOAD/" "${TARGET_DIR}/usr/local/bin"
 #+ Permissions
 sudo /bin/chmod u+s "${TARGET_DIR}/usr/local/bin/ardoff"
 #+ Permissions
 sudo /bin/chmod u+s "${TARGET_DIR}/usr/local/bin/ardon"
 #+ Permissions
 sudo /bin/chmod u+s "${TARGET_DIR}/usr/local/bin/sshon"
fi

#+ LaunchAgent
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchAgents/Sharing" Label "com.chrisgerke.Sharing"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchAgents/Sharing" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchAgents/Sharing" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/ard"

#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchAgents/Sharing.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchAgents/Sharing.plist"

#+ Load Agent
sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchAgents/Sharing.plist"

#+ LaunchDaemon
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/SSH" Label "com.chrisgerke.SSH"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/SSH" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/SSH" ProgramArguments -array "/usr/sbin/systemsetup" "-setremotelogin" "on"

#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchDaemons/SSH.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchDaemons/SSH.plist"

#+ Load Agent
sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchDaemons/SSH.plist"

exit 0
