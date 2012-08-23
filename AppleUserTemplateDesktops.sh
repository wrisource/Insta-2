#!/bin/sh
#* AppleUserTemplate
#+ chris.gerke@gmail.com 
#+
#+ Description: Payload required. Default Apple User Template preferences.
#+
#+ Version: 1.0
#+
#+ History:
#+     1.0: Script.
#+
#+ TODO:
#+     * Add more error checking?
#+     * Think about editing existing users?

ME=$0
SCRIPT_DIR="$1/Contents/Resources"
TARGET_DIR="$3"

DESKTOP="DEFAULT.png"
DESKTOP_DIR="/Library/ORG/Desktop"

#+ // fix
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

TARGET_OS=$(sudo /usr/bin/defaults read "${TARGET_DIR}/System/Library/CoreServices/SystemVersion" ProductVersion)

#* Detect payload & copy
if [ -r "${SCRIPT_DIR}/PAYLOAD" ]; then
 #+ Target
 sudo /bin/mkdir -p "${TARGET_DIR}/usr/local/bin"
 sudo /bin/mkdir -p "${TARGET_DIR}/${DESKTOP_DIR}"
 #+ Payload
 sudo /bin/cp -Rf "${SCRIPT_DIR}/PAYLOAD/Desktops/" "${TARGET_DIR}/${DESKTOP_DIR}"
fi

#+ Loop ${TARGET_DIR}/System/Library/User Template
for USER_TEMPLATE in `sudo ls ${TARGET_DIR}/System/Library/User\ Template`
do
 if [ -r "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences" ]; then
  
  #+ OK, so this is really ugly. I will work on making it nicer when I have time.
  sudo /bin/cat > "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.desktop.plist" << EOPROFILE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Background</key>
	<dict>
		<key>default</key>
		<dict>
			<key>BackgroundColor</key>
			<array>
				<real>0.0</real>
				<real>0.0</real>
				<real>0.0</real>
			</array>
			<key>DrawBackgroundColor</key>
			<true/>
			<key>ImageFilePath</key>
			<string>${DESKTOP_DIR}/${DESKTOP}</string>
			<key>Placement</key>
					<string>Centered</string>
		</dict>
		<key>spaces</key>
		<dict>
			<key></key>
			<dict>
				<key>0</key>
				<dict>
					<key>BackgroundColor</key>
					<array>
						<real>0.0</real>
						<real>0.0</real>
						<real>0.0</real>
					</array>
					<key>DSKDesktopPrefPane</key>
					<dict>
						<key>UserFolderPaths</key>
						<array>
							<string>${DESKTOP_DIR}</string>
						</array>
					</dict>
					<key>DrawBackgroundColor</key>
					<true/>
					<key>ImageFilePath</key>
					<string>${DESKTOP_DIR}/${DESKTOP}</string>
					<key>Placement</key>
					<string>Centered</string>
				</dict>
				<key>default</key>
				<dict>
					<key>BackgroundColor</key>
					<array>
						<real>0.0</real>
						<real>0.0</real>
						<real>0.0</real>
					</array>
					<key>ChangePath</key>
					<string>${DESKTOP_DIR}</string>
					<key>DrawBackgroundColor</key>
					<true/>
					<key>ImageFilePath</key>
					<string>${DESKTOP_DIR}/${DESKTOP}</string>
					<key>NoImage</key>
					<false/>
					<key>Placement</key>
					<string>Centered</string>
					<key>Random</key>
					<false/>
				</dict>
			</dict>
		</dict>
	</dict>
</dict>
</plist>

EOPROFILE
# End the ugliness
 
 fi
done

exit 0