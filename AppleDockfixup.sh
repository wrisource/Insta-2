#!/bin/sh
#* AppleDockfixup
#+ chris.gerke@gmail.com
#+
#+ Description: Payload free. Disable dockfixup.
#+
#+ Version: 1.0
#+
#+ History:
#+     1.0: Script.
#+
#+ TODO:
#+     * Add more error checking?

ME=$0
SCRIPT_DIR="$1/Contents/Resources"
TARGET_DIR="$3"

#+ // fix
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

#+ Disable dockfixup
DOCKFIXUP="${TARGET_DIR}/Library/Preferences/com.apple.dockfixup.plist"
[ -e "${DOCKFIXUP}" ] && sudo /bin/mv "${DOCKFIXUP}" "${DOCKFIXUP}.bak"

exit 0