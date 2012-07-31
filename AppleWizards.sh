#!/bin/sh
#* AppleWizards
#+ chris.gerke@gmail.com
#+
#+ Description: Payload free. Disable Apple Setup Wizard, Disable Registration Wizard.
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

#+ Disable Apple Setup Wizard
sudo /usr/bin/touch "${TARGET_DIR}/private/var/db/.AppleSetupDone"
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/private/var/db/.AppleSetupDone"

#* Disable Registration Wizard
sudo /usr/bin/touch "${TARGET_DIR}/Library/Receipts/.SetupRegComplete"
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/Receipts/.SetupRegComplete"

exit 0
