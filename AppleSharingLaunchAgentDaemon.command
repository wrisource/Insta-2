#!/bin/bash
 
WORKING_DIR=$(/usr/bin/dirname "${0}")

/bin/echo "${0} ${WORKING_DIR}"

#+ Copy MOTD from HOST to PKG
/bin/echo "Setting MOTD."
MOTD=$(sudo /bin/cat "/etc/motd" | awk NF)
if [ -z "${MOTD}" ] || [ "${MOTD}" != "" ]; then
 /usr/bin/defaults write "${WORKING_DIR}/config" MOTD "${MOTD}"
fi

#+ Copy VNC password from HOST to PKG
/bin/echo "Setting VNC password."
VNCPASSWD=$(sudo /bin/cat "/Library/Preferences/com.apple.VNCSettings.txt")
if [ -z "${VNCPASSWD}" ] || [ "${VNCPASSWD}" != "" ]; then
 /usr/bin/defaults write "${WORKING_DIR}/config" VNCPASSWD "${VNCPASSWD}"
fi

exit 0