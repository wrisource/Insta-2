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

#+ Admin check
sudo /bin/cat > "${TARGET_DIR}/usr/local/bin/ard" << EOPROFILE
#!/bin/sh
#* ard
#+ chris.gerke@gmail.com
#+
#+ Description: Enable sharing for admins, configure sharing for end users.
#+
#+ Version: 1.0
#+
#+ History:
#+     1.0: Script.
#+
#+ TODO:
#+     * Add error checking?

#+ Enable Remote Management automatically for admins otherwise configure it so end users have to accept a connection
/usr/bin/dsmemberutil checkmembership -U "\${USER}" -G admin | /usr/bin/grep "not"
if [ "\$?" == "0" ]; then
 /usr/local/bin/ardoff
else
 /usr/local/bin/ardon
fi

exit 0
EOPROFILE

#* Detect payload & copy
if [ -r "${SCRIPT_DIR}/PAYLOAD" ]; then
 #+ Target
 sudo /bin/mkdir -p "${TARGET_DIR}/usr/local/bin"
 #+ Payload
 sudo /bin/cp -Rf "${SCRIPT_DIR}/PAYLOAD/" "${TARGET_DIR}/usr/local/bin"
 #+ Permissions
 sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/usr/local/bin/ardoff"
 sudo /bin/chmod u+s "${TARGET_DIR}/usr/local/bin/ardoff"
 #+ Permissions
 sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/usr/local/bin/ardon"
 sudo /bin/chmod u+s "${TARGET_DIR}/usr/local/bin/ardon"
 #+ Permissions
 sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/usr/local/bin/sshon"
 sudo /bin/chmod u+s "${TARGET_DIR}/usr/local/bin/sshon"
fi

#+ LaunchAgent
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchAgents/AppleSharing" Label "com.cg.AppleSharing"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchAgents/AppleSharing" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchAgents/AppleSharing" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/ard"

#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchAgents/AppleSharing.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchAgents/AppleSharing.plist"

#+ Load if booted
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "" ]; then
 sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchAgents/AppleSharing.plist"
fi

#+ LaunchDaemon
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleSharingSSH" Label "com.cg.AppleSharingSSH"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleSharingSSH" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/AppleSharingSSH" ProgramArguments -array "/usr/sbin/systemsetup" "-setremotelogin" "on"

#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchDaemons/AppleSharingSSH.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchDaemons/AppleSharingSSH.plist"

#+ Load if booted
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "" ]; then
 sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchDaemons/AppleSharingSSH.plist"
fi

exit 0
