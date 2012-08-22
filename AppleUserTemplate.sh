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

DESKTOP="Default.png"
DESKTOP_DIR="/Library/ORG/Desktops"
HOMEPAGE="http://INTRANET"

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
 sudo /bin/cp -Rf "${SCRIPT_DIR}/PAYLOAD/dock" "${TARGET_DIR}/usr/local/bin/dock"
 #+ Payload
 sudo /bin/cp -Rf "${SCRIPT_DIR}/PAYLOAD/Desktops/" "${TARGET_DIR}/${DESKTOP_DIR}"
fi

#+ Loop ${TARGET_DIR}/System/Library/User Template
for USER_TEMPLATE in `sudo ls ${TARGET_DIR}/System/Library/User\ Template`
do
 if [ -r "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences" ]; then
  #+ com.apple.airplay.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.airplay.dock" showInMenuBarIfPresent -bool NO
  #+ com.apple.dock.plist (basic settings only).
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.dock" autohide -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.dock" launchanim -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.dock" mineffect -string "scale"
  #+ com.apple.driver.AppleBluetoothMultitouch.trackpad
  #+ (snow leopard)
  sudo /usr/bin/defaults write /Library/Preferences/.GlobalPreferences com.apple.mouse.tapBehavior -int 1
  #+ (multi touch snow leopard & lion done via ByHost)
  #sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.driver.AppleBluetoothMultitouch.trackpad" Clicking -bool YES
  #+ com.apple.ATS.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.ATS" ATSAutoActivation -string ATSAutoActivationDisable
  #+ com.apple.Console.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Console" ApplePersistenceIgnoreState YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Console" NSQuitAlwaysKeepsWindows -int 0
  #+ com.apple.CrashReporter.plist (hide from scared end users. maybe switch to basic mode...offers them the choice to delete prefs after second crash).
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.CrashReporter" DialogType Server
  #+ com.apple.desktopservices.plist (not doing this anymore. Causes weird behaviour with Windows Shares in pre 10.7).
  #sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.desktopservices" DSDontWriteNetworkStores -bool TRUE
  #+ com.apple.DiskUtility.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.DiskUtility" advanced-image-options -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.DiskUtility" DUDebugMenuEnabled -bool YES
  #+ com.apple.finder.plist (possibly redundant if DisableAllAnimations is TRUE, requires testing).
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" AnimateInfoPanes -bool false
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" AnimateWindowZoom -bool false
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" ZoomRects -bool false
  #+ Squeeze some more juice out of older macs? requires testing.
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" DisableAllAnimations -bool true
  #+ More informative Finder window
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" _FXShowPosixPathInTitle -bool YES
  #+ A little faster when opening Finder
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" FXDefaultSearchScope -string SCcf
  #+ Speed up finder info on remote volumes
  sudo /usr/libexec/PlistBuddy -c "Add :FXInfoPanesExpanded dict" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Add :FXInfoPanesExpanded:Comments bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Set :FXInfoPanesExpanded:Comments NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Add :FXInfoPanesExpanded:General bool YES" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Set :FXInfoPanesExpanded:General YES" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Add :FXInfoPanesExpanded:MetaData bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Set :FXInfoPanesExpanded:MetaData NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Add :FXInfoPanesExpanded:Name bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Set :FXInfoPanesExpanded:Name NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Add :FXInfoPanesExpanded:Preview bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Set :FXInfoPanesExpanded:Preview NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Add :FXInfoPanesExpanded:Privileges bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Set :FXInfoPanesExpanded:Privileges NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  #+ Just some standardisation
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" FXPreferredViewStyle -string Nlsv
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" NewWindowTarget -string PfHm
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" QLEnableTextSelection -bool TRUE
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" ShowHardDrivesOnDesktop -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" ShowMountedServersOnDesktop -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" ShowRemovableMediaOnDesktop -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" ShowPathbar -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" ShowStatusBar -bool YES
  #+ com.apple.FontBook.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.FontBook" FBValidateFontsBeforeInstalling -bool NO 
  #+ com.apple.iTunes.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disableCheckForUpdates -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disableGeniusSidebar -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disableGetAlbumArtwork -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disablePing -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disablePingSidebar -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disablePodcasts -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disableRadio -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disableSharedMusic -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" dontAutomaticallySyncIPods -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" lookForSharedMusic -bool NO
  #+ com.apple.NetworkBrowser.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.NetworkBrowser" DisableAirDrop -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.NetworkBrowser" BrowseAllInterfaces -bool NO
  #+ com.apple.print.PrintingPrefs
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.print.PrintingPrefs" "Quit When Finished" -bool true
  #+ com.apple.Safari.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" ApplePersistenceIgnoreState YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" AutoFillFromAddressBook -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" AutoFillMiscellaneousForms -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" AutoFillPasswords -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" DomainsToNeverSetUp -array "aol.com" "facebook.com" "flickr.com" "google.com" "twitter.com" "vimeo.com" "yahoo.com"
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" IncludeDebugMenu 1
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" LastDisplayedWelcomePageVersionString -string 4.0
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" NewWindowBehaviour 0
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" NSQuitAlwaysKeepsWindows -int 0
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" RestoreSessionAtLaunch -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" WebKitJavaScriptCanOpenWindowsAutomatically -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" ShowStatusBar -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" HomePage "${HOMEPAGE}"
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.internetconfigpriv" WWWHomePage "${HOMEPAGE}"
  #+ com.apple.SetupAssistant.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.SetupAssistant" DidSeeCloudSetup -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.SetupAssistant" GestureMovieSeen none
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.SetupAssistant" LastSeenCloudProductVersion "10.8"
  #+ com.apple.systempreferences.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.systempreferences" HiddenPreferencePanes -array "com.apple.preference.notifications" "com.apple.preference.startupdisk" "com.apple.prefs.backup" "com.apple.preferences.softwareupdate" "com.apple.preferences.parentalcontrols" "com.apple.preference.internet" "com.apple.preferences.internetaccounts" "com.apple.preferences.icloud" "com.apple.preferences.sharing" "com.apple.preference.desktopscreeneffect" "com.apple.preference.security" "com.apple.preference.engerysaver" "com.NT-Ware.UniFLOWMacClientConfig"
  #+ com.apple.symbolichotkeys.plist (Disable Dashboard and Mission Control Keys so they are default Fn keys), arrggg! changes every time the OS adds functionality or new keys. Find and disable 10.8 dictation key.
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:32:enabled bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:32:enabled NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:33:enabled bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:33:enabled NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:34:enabled bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:34:enabled NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:35:enabled bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:35:enabled NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:36:enabled bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:36:enabled NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:37:enabled bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:37:enabled NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:52:enabled bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:52:enabled NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:59:enabled bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:59:enabled NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:62:enabled bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:62:enabled NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:63:enabled bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:63:enabled NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:64:enabled bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:64:enabled NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:65:enabled bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:65:enabled NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:73:enabled bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:73:enabled NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  #+ com.apple.TimeMachine.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.TimeMachine" DoNotOfferNewDisksForBackup -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.TimeMachine" AutoBackup -bool NO
  #+ com.apple.universalaccess.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.universalaccess" voiceOverOnOffKey -bool NO
  #+ .GlobalPreferences
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" AppleKeyboardUIMode -int 2
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" AppleMiniaturizeOnDoubleClick -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" AppleShowAllExtensions -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" AppleShowScrollBars -string "Always" 
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" NSAutomaticSpellingCorrectionEnabled -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" NSAutomaticWindowAnimationsEnabled -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" NSDocumentSaveNewDocumentsToCloud -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" NSNavPanelExpandedStateForSaveMode -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" NSQuitAlwaysKeepsWindows -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" PMPrintingExpandedStateForPrint -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" com.apple.swipescrolldirection -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" com.apple.keyboard.fnState -bool YES
  
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
  
  #+ OK, so this is really ugly but the only way to do it if you want to avoid supplying payloads items. I will work on making it nicer when I have time.
  sudo /bin/cat > "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.sidebarlists.plist" << EOPROFILE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>favorites</key>
	<dict>
		<key>Controller</key>
		<string>VolumesList</string>
		<key>CustomListProperties</key>
		<dict>
			<key>com.apple.LSSharedFileList.Restricted.upgraded</key>
			<true/>
			<key>com.apple.LSSharedFileList.VolumesListMigrated</key>
			<true/>
		</dict>
		<key>ShowEjectables</key>
		<true/>
		<key>ShowHardDisks</key>
		<true/>
		<key>ShowRemovable</key>
		<true/>
		<key>ShowServers</key>
		<true/>
		<key>VolumesList</key>
		<array>
			<dict>
				<key>EntryType</key>
				<integer>16</integer>
				<key>Name</key>
				<string>iDisk</string>
				<key>SpecialID</key>
				<integer>1766093675</integer>
				<key>Visibility</key>
				<string>NeverVisible</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAAB2AAMAAQAAyk1lwwAASCsAAAAAAAAAAgABB1gA
				AMoisLgAAAAACSD//gAAAAAAAAAA/////wABAAAADgAQ
				AAcATgBlAHQAdwBvAHIAawAPAAoABABPAFMAWABMABIA
				B05ldHdvcmsAABMAAS8A//8AAA==
				</data>
				<key>EntryType</key>
				<integer>16</integer>
				<key>Name</key>
				<string>Network</string>
				<key>SpecialID</key>
				<integer>1735288180</integer>
				<key>Visibility</key>
				<string>NeverVisible</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAACEAAMAAQAAyk1lwwAASCsAAAAAAAAAAgAAAKUA
				AMoBn94AAAAACSD//gAAAAAAAAAA/////wABAAAADgAa
				AAwAQQBwAHAAbABpAGMAYQB0AGkAbwBuAHMADwAKAAQA
				TwBTAFgATAASAAxBcHBsaWNhdGlvbnMAEwABLwD//wAA
				</data>
				<key>CustomItemProperties</key>
				<dict>
					<key>com.apple.LSSharedFileList.TemplateSystemSelector</key>
					<integer>1935819120</integer>
				</dict>
				<key>Icon</key>
				<data>
				SW1nUgAAASIAAAAARkJJTAAAARYAAAACAAAAAAAAAAAB
				BgADAAAAAMpNZcMAAEgrAAAAAAAACycAADnYAADKKdM8
				AAAAAAkg//4AAAAAAAAAAP////8AAQAYAAALJwAACTkA
				AAk4AAAAhgAAAHkAAAB4AA4ANgAaAFQAbwBvAGwAYgBh
				AHIAQQBwAHAAcwBGAG8AbABkAGUAcgBJAGMAbwBuAC4A
				aQBjAG4AcwAPAAoABABPAFMAWABMABIAWlN5c3RlbS9M
				aWJyYXJ5L0NvcmVTZXJ2aWNlcy9Db3JlVHlwZXMuYnVu
				ZGxlL0NvbnRlbnRzL1Jlc291cmNlcy9Ub29sYmFyQXBw
				c0ZvbGRlckljb24uaWNucwATAAEvAP//AAA=
				</data>
				<key>Name</key>
				<string>Applications</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAACYAAMAAQAAyk1lwwAASCsAAAAAAAStUAAErVIA
				AMpOkJUAAAAACSD//gAAAAAAAAAA/////wABAAwABK1Q
				AAAAaAAAAGQADgAQAAcARABlAHMAawB0AG8AcAAPAAoA
				BABPAFMAWABMABIAF3ByaXZhdGUvdmFyL2FyZC9EZXNr
				dG9wAAATAAEvAAAVAAIAEP//AAA=
				</data>
				<key>CustomItemProperties</key>
				<dict>
					<key>com.apple.LSSharedFileList.TemplateSystemSelector</key>
					<integer>1935819892</integer>
				</dict>
				<key>Icon</key>
				<data>
				SW1nUgAAASwAAAAARkJJTAAAASAAAAACAAAAAAAAAAAB
				EAADAAAAAMpNZcMAAEgrAAAAAAAACycAADnbAADKKdM8
				AAAAAAkg//4AAAAAAAAAAP////8AAQAYAAALJwAACTkA
				AAk4AAAAhgAAAHkAAAB4AA4APAAdAFQAbwBvAGwAYgBh
				AHIARABlAHMAawB0AG8AcABGAG8AbABkAGUAcgBJAGMA
				bwBuAC4AaQBjAG4AcwAPAAoABABPAFMAWABMABIAXVN5
				c3RlbS9MaWJyYXJ5L0NvcmVTZXJ2aWNlcy9Db3JlVHlw
				ZXMuYnVuZGxlL0NvbnRlbnRzL1Jlc291cmNlcy9Ub29s
				YmFyRGVza3RvcEZvbGRlckljb24uaWNucwAAEwABLwD/
				/wAA
				</data>
				<key>Name</key>
				<string>Desktop</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAACeAAMAAQAAyk1lwwAASCsAAAAAAAStUAAEvfgA
				AMpOnyoAAAAACSD//gAAAAAAAAAA/////wABAAwABK1Q
				AAAAaAAAAGQADgAUAAkARABvAGMAdQBtAGUAbgB0AHMA
				DwAKAAQATwBTAFgATAASABlwcml2YXRlL3Zhci9hcmQv
				RG9jdW1lbnRzAAATAAEvAAAVAAIAEP//AAA=
				</data>
				<key>CustomItemProperties</key>
				<dict>
					<key>com.apple.LSSharedFileList.TemplateSystemSelector</key>
					<integer>1935819875</integer>
				</dict>
				<key>Icon</key>
				<data>
				SW1nUgAAATIAAAAARkJJTAAAASYAAAACAAAAAAAAAAAB
				FgADAAAAAMpNZcMAAEgrAAAAAAAACycAADncAADKKdM8
				AAAAAAkg//4AAAAAAAAAAP////8AAQAYAAALJwAACTkA
				AAk4AAAAhgAAAHkAAAB4AA4AQAAfAFQAbwBvAGwAYgBh
				AHIARABvAGMAdQBtAGUAbgB0AHMARgBvAGwAZABlAHIA
				SQBjAG8AbgAuAGkAYwBuAHMADwAKAAQATwBTAFgATAAS
				AF9TeXN0ZW0vTGlicmFyeS9Db3JlU2VydmljZXMvQ29y
				ZVR5cGVzLmJ1bmRsZS9Db250ZW50cy9SZXNvdXJjZXMv
				VG9vbGJhckRvY3VtZW50c0ZvbGRlckljb24uaWNucwAA
				EwABLwD//wAA
				</data>
				<key>Name</key>
				<string>Documents</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAACeAAMAAQAAyk1lwwAASCsAAAAAAAStUAAEvc4A
				AMpOnyoAAAAACSD//gAAAAAAAAAA/////wABAAwABK1Q
				AAAAaAAAAGQADgAUAAkARABvAHcAbgBsAG8AYQBkAHMA
				DwAKAAQATwBTAFgATAASABlwcml2YXRlL3Zhci9hcmQv
				RG93bmxvYWRzAAATAAEvAAAVAAIAEP//AAA=
				</data>
				<key>CustomItemProperties</key>
				<dict>
					<key>com.apple.LSSharedFileList.TemplateSystemSelector</key>
					<integer>1935819884</integer>
				</dict>
				<key>Icon</key>
				<data>
				SW1nUgAAABwAAAAAU1lTTAAAABAAAAAAdER3bg==
				</data>
				<key>Name</key>
				<string>Downloads</string>
			</dict>
		</array>
	</dict>
	<key>networkbrowser</key>
	<dict>
		<key>Controller</key>
		<string>CustomListItems</string>
		<key>CustomListItems</key>
		<array/>
		<key>CustomListProperties</key>
		<dict>
			<key>com.apple.NetworkBrowser.backToMyMacEnabled</key>
			<false/>
			<key>com.apple.NetworkBrowser.bonjourEnabled</key>
			<false/>
		</dict>
	</dict>
	<key>savedsearches</key>
	<dict>
		<key>Controller</key>
		<string>CustomListItems</string>
		<key>CustomListItems</key>
		<array>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAAD8AAMAAQAAyk1lwwAASCsAAAAAAAC5ywAAuhQA
				AMoorHUAAAAACSD//gAAAAAAAAAA/////wABABwAALnL
				AAC5vwAAuboAALm5AAAAhgAAAHkAAAB4AA4AJgASAFQA
				bwBkAGEAeQAuAGMAYQBuAG4AZQBkAFMAZQBhAHIAYwBo
				AA8ACgAEAE8AUwBYAEwAEgBbU3lzdGVtL0xpYnJhcnkv
				Q29yZVNlcnZpY2VzL0ZpbmRlci5hcHAvQ29udGVudHMv
				UmVzb3VyY2VzL0Nhbm5lZFNlYXJjaGVzL1RvZGF5LmNh
				bm5lZFNlYXJjaAAAEwABLwD//wAA
				</data>
				<key>Icon</key>
				<data>
				SW1nUgAAASQAAAAARkJJTAAAARgAAAACAAAAAAAAAAAB
				CAADAAAAAMpNZcMAAEgrAAAAAAAAuhUAALoZAADKKKx1
				AAAAAAkg//4AAAAAAAAAAP////8AAQAkAAC6FQAAuhQA
				ALnLAAC5vwAAuboAALm5AAAAhgAAAHkAAAB4AA4AFgAK
				AFQAbwBkAGEAeQAuAGkAYwBuAHMADwAKAAQATwBTAFgA
				TAASAHBTeXN0ZW0vTGlicmFyeS9Db3JlU2VydmljZXMv
				RmluZGVyLmFwcC9Db250ZW50cy9SZXNvdXJjZXMvQ2Fu
				bmVkU2VhcmNoZXMvVG9kYXkuY2FubmVkU2VhcmNoL1Jl
				c291cmNlcy9Ub2RheS5pY25zABMAAS8A//8AAA==
				</data>
				<key>Name</key>
				<string>Today</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAAEIAAMAAQAAyk1lwwAASCsAAAAAAAC5ywAAuhwA
				AMoorHUAAAAACSD//gAAAAAAAAAA/////wABABwAALnL
				AAC5vwAAuboAALm5AAAAhgAAAHkAAAB4AA4ALgAWAFkA
				ZQBzAHQAZQByAGQAYQB5AC4AYwBhAG4AbgBlAGQAUwBl
				AGEAcgBjAGgADwAKAAQATwBTAFgATAASAF9TeXN0ZW0v
				TGlicmFyeS9Db3JlU2VydmljZXMvRmluZGVyLmFwcC9D
				b250ZW50cy9SZXNvdXJjZXMvQ2FubmVkU2VhcmNoZXMv
				WWVzdGVyZGF5LmNhbm5lZFNlYXJjaAAAEwABLwD//wAA
				</data>
				<key>Icon</key>
				<data>
				SW1nUgAAATQAAAAARkJJTAAAASgAAAACAAAAAAAAAAAB
				GAADAAAAAMpNZcMAAEgrAAAAAAAAuh0AALohAADKKKx1
				AAAAAAkg//4AAAAAAAAAAP////8AAQAkAAC6HQAAuhwA
				ALnLAAC5vwAAuboAALm5AAAAhgAAAHkAAAB4AA4AHgAO
				AFkAZQBzAHQAZQByAGQAYQB5AC4AaQBjAG4AcwAPAAoA
				BABPAFMAWABMABIAeFN5c3RlbS9MaWJyYXJ5L0NvcmVT
				ZXJ2aWNlcy9GaW5kZXIuYXBwL0NvbnRlbnRzL1Jlc291
				cmNlcy9DYW5uZWRTZWFyY2hlcy9ZZXN0ZXJkYXkuY2Fu
				bmVkU2VhcmNoL1Jlc291cmNlcy9ZZXN0ZXJkYXkuaWNu
				cwATAAEvAP//AAA=
				</data>
				<key>Name</key>
				<string>Yesterday</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAAEIAAMAAQAAyk1lwwAASCsAAAAAAAC5ywAAugwA
				AMoorHUAAAAACSD//gAAAAAAAAAA/////wABABwAALnL
				AAC5vwAAuboAALm5AAAAhgAAAHkAAAB4AA4ALgAWAFAA
				YQBzAHQAIABXAGUAZQBrAC4AYwBhAG4AbgBlAGQAUwBl
				AGEAcgBjAGgADwAKAAQATwBTAFgATAASAF9TeXN0ZW0v
				TGlicmFyeS9Db3JlU2VydmljZXMvRmluZGVyLmFwcC9D
				b250ZW50cy9SZXNvdXJjZXMvQ2FubmVkU2VhcmNoZXMv
				UGFzdCBXZWVrLmNhbm5lZFNlYXJjaAAAEwABLwD//wAA
				</data>
				<key>Icon</key>
				<data>
				SW1nUgAAATIAAAAARkJJTAAAASYAAAACAAAAAAAAAAAB
				FgADAAAAAMpNZcMAAEgrAAAAAAAAug0AALoRAADKKKx1
				AAAAAAkg//4AAAAAAAAAAP////8AAQAkAAC6DQAAugwA
				ALnLAAC5vwAAuboAALm5AAAAhgAAAHkAAAB4AA4AHAAN
				AFQAaABpAHMAVwBlAGUAawAuAGkAYwBuAHMADwAKAAQA
				TwBTAFgATAASAHdTeXN0ZW0vTGlicmFyeS9Db3JlU2Vy
				dmljZXMvRmluZGVyLmFwcC9Db250ZW50cy9SZXNvdXJj
				ZXMvQ2FubmVkU2VhcmNoZXMvUGFzdCBXZWVrLmNhbm5l
				ZFNlYXJjaC9SZXNvdXJjZXMvVGhpc1dlZWsuaWNucwAA
				EwABLwD//wAA
				</data>
				<key>Name</key>
				<string>Past Week</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAAEUAAMAAQAAyk1lwwAASCsAAAAAAAC5ywAAudQA
				AMoorHUAAAAACSD//gAAAAAAAAAA/////wABABwAALnL
				AAC5vwAAuboAALm5AAAAhgAAAHkAAAB4AA4ANgAaAEEA
				bABsACAARABvAGMAdQBtAGUAbgB0AHMALgBjAGEAbgBu
				AGUAZABTAGUAYQByAGMAaAAPAAoABABPAFMAWABMABIA
				Y1N5c3RlbS9MaWJyYXJ5L0NvcmVTZXJ2aWNlcy9GaW5k
				ZXIuYXBwL0NvbnRlbnRzL1Jlc291cmNlcy9DYW5uZWRT
				ZWFyY2hlcy9BbGwgRG9jdW1lbnRzLmNhbm5lZFNlYXJj
				aAAAEwABLwD//wAA
				</data>
				<key>Icon</key>
				<data>
				SW1nUgAAAP4AAAAARkJJTAAAAPIAAAACAAAAAAAAAAAA
				4gADAAAAAMpNZcMAAEgrAAAAAAAAub8AALqVAADKKKxs
				AAAAAAkg//4AAAAAAAAAAP////8AAQAYAAC5vwAAuboA
				ALm5AAAAhgAAAHkAAAB4AA4AIgAQAFMAbQBhAHIAdABG
				AG8AbABkAGUAcgAuAGkAYwBuAHMADwAKAAQATwBTAFgA
				TAASAEpTeXN0ZW0vTGlicmFyeS9Db3JlU2VydmljZXMv
				RmluZGVyLmFwcC9Db250ZW50cy9SZXNvdXJjZXMvU21h
				cnRGb2xkZXIuaWNucwATAAEvAP//AAA=
				</data>
				<key>Name</key>
				<string>All Documents</string>
			</dict>
		</array>
	</dict>
	<key>systemitems</key>
	<dict>
		<key>Controller</key>
		<string>VolumesList</string>
		<key>CustomListProperties</key>
		<dict>
			<key>com.apple.LSSharedFileList.VolumesListMigrated</key>
			<true/>
		</dict>
		<key>ShowEjectables</key>
		<true/>
		<key>ShowHardDisks</key>
		<true/>
		<key>ShowRemovable</key>
		<true/>
		<key>ShowServers</key>
		<true/>
		<key>VolumesList</key>
		<array>
			<dict>
				<key>EntryType</key>
				<integer>16</integer>
				<key>Flags</key>
				<integer>1</integer>
				<key>Name</key>
				<string>Computer</string>
				<key>SpecialID</key>
				<integer>1919905652</integer>
				<key>Visibility</key>
				<string>AlwaysVisible</string>
			</dict>
			<dict>
				<key>EntryType</key>
				<integer>16</integer>
				<key>Name</key>
				<string>iDisk</string>
				<key>SpecialID</key>
				<integer>1766093675</integer>
				<key>Visibility</key>
				<string>NeverVisible</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAAB2AAMAAQAAyk1lwwAASCsAAAAAAAAAAgABB1gA
				AMoisLgAAAAACSD//gAAAAAAAAAA/////wABAAAADgAQ
				AAcATgBlAHQAdwBvAHIAawAPAAoABABPAFMAWABMABIA
				B05ldHdvcmsAABMAAS8A//8AAA==
				</data>
				<key>EntryType</key>
				<integer>16</integer>
				<key>Name</key>
				<string>Network</string>
				<key>SpecialID</key>
				<integer>1735288180</integer>
				<key>Visibility</key>
				<string>NeverVisible</string>
			</dict>
		</array>
	</dict>
</dict>
</plist>
EOPROFILE
# End the ugliness


  #+ Third Party
  
  #+ com.adobe.crashreporter
  sudo /usr/bin/defaults write "/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.crashreporter" always_never_send -int 2
  #+ com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10 dict" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10:AVGeneral dict" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10:AVGeneral:CheckForUpdatesAtStartup array" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10:AVGeneral:CheckForUpdatesAtStartup:0 integer 0" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Set :10:AVGeneral:CheckForUpdatesAtStartup:0 0" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10:AVGeneral:CheckForUpdatesAtStartup:1 bool NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Set :10:AVGeneral:CheckForUpdatesAtStartup:1 NO" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  #+ Adobe Lightroom
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Lightroom2" noAutomaticallyCheckUpdates -bool true
  #+ CyberDuck
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" connection.login.useKeychain -string false
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" donate.reminder -string 4.2.1
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" donate.reminder.date -string 1333064699726
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" SUCheckAtStartup -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" update.check -string FALSE
  #+ Flip4Mac
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/net.telestream.wmv" UpdateCheck_CheckInterval -int 9999
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/net.telestream.wmv.plugin" ShowController -bool YES
  #+ Growl
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlDisplayPluginName -string "Music Video"
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlEnabled -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlEnableForward -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlLoggingEnabled -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlMenuExtra -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlStartServer -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlUpdateCheck -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" StickyWhenAway -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" com.Growl.MusicVideo -dict
  sudo /usr/libexec/PlistBuddy -c "Add :com.Growl.MusicVideo dict" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  sudo /usr/libexec/PlistBuddy -c "Add :com.Growl.MusicVideo:Duration integer 0" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  sudo /usr/libexec/PlistBuddy -c "Set :com.Growl.MusicVideo:Duration 0" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  sudo /usr/libexec/PlistBuddy -c "Add :com.Growl.MusicVideo:Opacity integer 0" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  sudo /usr/libexec/PlistBuddy -c "Set :com.Growl.MusicVideo:Opacity 0" ${TARGET_DIR}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  #+ Microsoft Office
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.microsoft.autoupdate2" HowToCheck -string Manual
  #+ Stuffit Expander
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.stuffit.StuffIt-Expander" moveToApplicationsFolderAlertSuppress -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.stuffit.StuffIt-Expander" registrationAction -int 2
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.stuffit.StuffIt-Expander" SUEnableAutomaticChecks -bool NO
 fi
done

exit 0