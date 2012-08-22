#!/bin/sh
#* Apple User Template
#+ chris.gerke@gmail.com
#+
#+ Description: Payload required. Default Apple User Template preferences.
#+
#+ Version: 1.0
#+
#+ History:
#+     1.0: Script EOPROFILE.
#+
#+ TODO:
#+     * Add more error checking?
#+     * Think about editing existing users?

ME=$0
SCRIPT_DIR="$1/Contents/Resources"
TARGET_DIR="$3"

#+ // fix
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

#* Detect payload & copy
if [ -r "${SCRIPT_DIR}/PAYLOAD" ]; then
 #+ TARGET_DIR
 sudo /bin/mkdir -p "${TARGET_DIR}/usr/local/bin"
 #+ Payload
 sudo /bin/cp -Rf "${SCRIPT_DIR}/PAYLOAD/" "${TARGET_DIR}/usr/local/bin"
fi

sudo /bin/rm -f "${TARGET_DIR}/Library/Preferences/com.apple.dockfixup.plist"

#+ Modify ${TARGET_DIR}/System/Library/User Template/Library/Preferences/com.apple.dock.plist
for USER_TEMPLATE in `sudo /bin/ls "${TARGET_DIR}/System/Library/User Template"`
do
 if [ -r "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences" ]; then
 
  #+ OK, so this is really ugly but the only way to do it if you want to avoid supplying payloads items. I will work on making it nicer when I have time.
  sudo /bin/cat > "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.dock.plist" << EOPROFILE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>autohide</key>
	<false/>
	<key>launchanim</key>
	<false/>
	<key>mineffect</key>
	<string>scale</string>
	<key>mod-count</key>
	<integer>6</integer>
	<key>persistent-apps</key>
	<array/>
	<key>persistent-others</key>
	<array>
		<dict>
			<key>GUID</key>
			<integer>30450216</integer>
			<key>tile-data</key>
			<dict>
				<key>arrangement</key>
				<integer>1</integer>
				<key>displayas</key>
				<integer>1</integer>
				<key>file-data</key>
				<dict>
					<key>_CFURLAliasData</key>
					<data>
					AAAAAAC2AAMAAQAAy2s50QAASCsAAAAAAAE+
					BAABPgUAAMtrNbIAAAAACSD//gAAAAAAAAAA
					/////wABAAwAAT4EAAE+AgABBpwADgAiABAA
					UgBEAEEAIABBAHAAcABsAGkAYwBhAHQAaQBv
					AG4AcwAPAA4ABgBTAHkAcwB0AGUAbQASACZM
					aWJyYXJ5L1JEQS9Eb2NrSXRlbXMvUkRBIEFw
					cGxpY2F0aW9ucwATAAEvAP//AAA=
					</data>
					<key>_CFURLString</key>
					<string>file://localhost/Library/RDA/DockItems/RDA%20Applications/</string>
					<key>_CFURLStringType</key>
					<integer>15</integer>
				</dict>
				<key>file-label</key>
				<string>RDA Applications</string>
				<key>file-mod-date</key>
				<integer>0</integer>
				<key>file-type</key>
				<integer>2</integer>
				<key>parent-mod-date</key>
				<integer>0</integer>
				<key>preferreditemsize</key>
				<integer>-1</integer>
				<key>showas</key>
				<integer>3</integer>
			</dict>
			<key>tile-type</key>
			<string>directory-tile</string>
		</dict>
		<dict>
			<key>GUID</key>
			<integer>357144811</integer>
			<key>tile-data</key>
			<dict>
				<key>arrangement</key>
				<integer>1</integer>
				<key>displayas</key>
				<integer>1</integer>
				<key>file-data</key>
				<dict>
					<key>_CFURLAliasData</key>
					<data>
					AAAAAACuAAMAAQAAy2s50QAASCsAAAAAAAE+
					BAABPggAAMtp9qUAAAAACSD//gAAAAAAAAAA
					/////wABAAwAAT4EAAE+AgABBpwADgAcAA0A
					UgBEAEEAIABEAG8AYwB1AG0AZQBuAHQAcwAP
					AA4ABgBTAHkAcwB0AGUAbQASACNMaWJyYXJ5
					L1JEQS9Eb2NrSXRlbXMvUkRBIERvY3VtZW50
					cwAAEwABLwD//wAA
					</data>
					<key>_CFURLString</key>
					<string>file://localhost/Library/RDA/DockItems/RDA%20Documents/</string>
					<key>_CFURLStringType</key>
					<integer>15</integer>
				</dict>
				<key>file-label</key>
				<string>RDA Documents</string>
				<key>file-mod-date</key>
				<integer>0</integer>
				<key>file-type</key>
				<integer>2</integer>
				<key>parent-mod-date</key>
				<integer>0</integer>
				<key>preferreditemsize</key>
				<integer>-1</integer>
				<key>showas</key>
				<integer>3</integer>
			</dict>
			<key>tile-type</key>
			<string>directory-tile</string>
		</dict>
		<dict>
			<key>GUID</key>
			<integer>216516310</integer>
			<key>tile-data</key>
			<dict>
				<key>arrangement</key>
				<integer>1</integer>
				<key>displayas</key>
				<integer>1</integer>
				<key>file-data</key>
				<dict>
					<key>_CFURLAliasData</key>
					<data>
					AAAAAACqAAMAAQAAy2s50QAASCsAAAAAAAE+
					BAABPgoAAMtrNdcAAAAACSD//gAAAAAAAAAA
					/////wABAAwAAT4EAAE+AgABBpwADgAaAAwA
					UgBEAEEAIABIAGUAbABwAGQAZQBzAGsADwAO
					AAYAUwB5AHMAdABlAG0AEgAiTGlicmFyeS9S
					REEvRG9ja0l0ZW1zL1JEQSBIZWxwZGVzawAT
					AAEvAP//AAA=
					</data>
					<key>_CFURLString</key>
					<string>file://localhost/Library/RDA/DockItems/RDA%20Helpdesk/</string>
					<key>_CFURLStringType</key>
					<integer>15</integer>
				</dict>
				<key>file-label</key>
				<string>RDA Helpdesk</string>
				<key>file-mod-date</key>
				<integer>0</integer>
				<key>file-type</key>
				<integer>2</integer>
				<key>parent-mod-date</key>
				<integer>0</integer>
				<key>preferreditemsize</key>
				<integer>-1</integer>
				<key>showas</key>
				<integer>3</integer>
			</dict>
			<key>tile-type</key>
			<string>directory-tile</string>
		</dict>
	</array>
	<key>version</key>
	<integer>1</integer>
</dict>
</plist>
EOPROFILE
# End the ugliness
 
 fi
done

exit 0