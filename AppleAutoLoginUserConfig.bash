#!/bin/bash
 
WORKING_DIR=$(/usr/bin/dirname "${0}")

/bin/echo "${0} ${WORKING_DIR}"

#+ Specify the user
/bin/echo "Set AutoLoginUser shortname?"
read AUTOLOGINUSER

#+ kcpassword
/bin/echo "kcpassword ready? attempting to copy."
sudo /bin/cp -f /etc/kcpassword "${WORKING_DIR}/PAYLOAD/kcpassword"
#if [ $? == 0 ]; then
 #+ Plist key
 /usr/bin/defaults write "${WORKING_DIR}/config" AUTOLOGINUSER "${AUTOLOGINUSER}"
#fi

exit 0