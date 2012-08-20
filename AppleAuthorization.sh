#!/bin/sh
#* AppleAuthorization
#+ chris.gerke@gmail.com
#+
#+ Description: Payload free. Auth tweaks for 10.7 (and previous OS versions)
#+
#+ Version: 1.0
#+
#+ History:
#+     1.0: Script.
#+
#+ TODO:
#+     * Add more error checking?
#+     * Think about testing for OS version? ie, screensaver option changed in 10.7

ME=$0
SCRIPT_DIR="$1/Contents/Resources"
TARGET_DIR="$3"

#+ // fix
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

#* Authorization, if you don't know what this is you shouldn't mess with it ;)

#+ Backup Original
sudo /bin/cp -f "${TARGET_DIR}/etc/authorization" "${TARGET_DIR}/etc/authorization.original"

#+ Allow date & time preference pane access.
sudo /usr/libexec/PlistBuddy -c "set rights:system.preferences.datetime:class allow" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences.datetime:shared" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences.datetime:group" "${TARGET_DIR}/etc/authorization"

#+ Allow DVD region setting rights
sudo /usr/libexec/PlistBuddy -c "add rights:system.device.dvd.setregion.change dict" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "add rights:system.device.dvd.setregion.change:class string" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "set rights:system.device.dvd.setregion.change:class allow" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.device.dvd.setregion.change:shared" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.device.dvd.setregion.change:group" "${TARGET_DIR}/etc/authorization"

#+ Allow DVD region initial setting rights
sudo /usr/libexec/PlistBuddy -c "set rights:system.device.dvd.setregion.initial:class allow" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.device.dvd.setregion.initial:shared" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.device.dvd.setregion.initial:group" "${TARGET_DIR}/etc/authorization"

#+ Allow network preference pane access
sudo /usr/libexec/PlistBuddy -c "set rights:system.preferences.network:class allow" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences.network:shared" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences.network:group" "${TARGET_DIR}/etc/authorization"

#+ Change ${TARGET_DIR}/etc/authorization to allow all users to open preference panes
sudo /usr/libexec/PlistBuddy -c "set rights:system.preferences.printing:class allow" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences.printing:shared" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences.printing:group" "${TARGET_DIR}/etc/authorization"

#+ Allow preference panes
sudo /usr/libexec/PlistBuddy -c "set rights:system.preferences:class allow" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences:shared" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.preferences:group" "${TARGET_DIR}/etc/authorization"

#+ Allow print admin rights
sudo /usr/libexec/PlistBuddy -c "set rights:system.print.admin:class allow" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.print.admin:group" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.print.admin:shared" "${TARGET_DIR}/etc/authorization"

#+ Allow printing manager rights
sudo /usr/libexec/PlistBuddy -c "set rights:system.printingmanager:class allow" "${TARGET_DIR}/etc/authorization"
sudo /usr/libexec/PlistBuddy -c "delete rights:system.printingmanager:rule" "${TARGET_DIR}/etc/authorization"

#+ Allow admin to unlock screensaver, test this... changed in 10.7
sudo /usr/libexec/PlistBuddy -c "set :rights:system.login.screensaver:comment \"(Use SecurityAgent.) The owner or any administrator can unlock the screensaver.\"" "${TARGET_DIR}/etc/authorization"

#+ Permissions
sudo chown root:wheel "${TARGET_DIR}/etc/authorization"
sudo chmod 644 "${TARGET_DIR}/etc/authorization"

exit 0