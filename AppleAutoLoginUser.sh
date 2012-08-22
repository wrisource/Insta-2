#!/bin/sh
#* AppleAutoLoginUser
#+ chris.gerke@gmail.com
#+
#+ Description: Payload required. Auto login a specified user.
#+
#+ Version: 2.0
#+
#+ History:
#+     2.0: Error checking.
#+
#+ TODO:
#+     * Dynamic kcpassword creation?

ME=$0
SCRIPT_DIR="$1/Contents/Resources"
TARGET_DIR="$3"

AUTOLOGINUSER=$(sudo /usr/bin/defaults read "${SCRIPT_DIR}/config" autoLoginUser)

#+ // fix
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

#+ AUTOLOGINUSER specified?
if [ -z "${AUTOLOGINUSER}" ] || [ "${AUTOLOGINUSER}" != "" ]; then
 #* Detect payload & copy
 if [ -r "${SCRIPT_DIR}/PAYLOAD/kcpassword" ]; then
  #+ kcpassword
  sudo /bin/cp -f "${SCRIPT_DIR}/PAYLOAD/kcpassword" "${TARGET_DIR}/etc/kcpassword"
  #+ Permissions
  sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/etc/kcpassword"
  sudo /bin/chmod 600 "${TARGET_DIR}/etc/kcpassword"
  sudo /bin/rm -Rf "${TARGET_DIR}/etc/kcpassword.disabled"
  #+ ${TARGET_DIR}/Library/Preferences/com.apple.loginwindow.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/Library/Preferences/com.apple.loginwindow" autoLoginUser -string "${AUTOLOGINUSER}"
  sudo /bin/rm -Rf "${TARGET_DIR}/Library/Preferences/com.apple.loginwindow.plist.lockfile"
  #+ Permissions
  sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/Preferences/com.apple.loginwindow.plist"
  sudo /bin/chmod 644 "${TARGET_DIR}/Library/Preferences/com.apple.loginwindow.plist"
 fi
fi

exit 0