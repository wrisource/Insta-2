#!/bin/sh
#* AppleUserTemplate
#+ chris.gerke@gmail.com
#+
#+ Description: Payload free. Default Apple User Template preferences.
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

HOMEPAGE="http://INTRANET"

#+ // fix for PKG
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

#+ Loop ${TARGET_DIR}/System/Library/User Template
for USER_TEMPLATE in `sudo ls ${TARGET_DIR}/System/Library/User\ Template`
do
 if [ -r "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences" ]; then
  #+ com.apple.dock.plist (basic settings only).
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.dock" autohide -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.dock" launchanim -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.dock" mineffect -string "scale"
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
  #+ com.apple.Safari.plist
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" ApplePersistenceIgnoreState YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" AutoFillFromAddressBook -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" AutoFillMiscellaneousForms -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" AutoFillPasswords -bool NO
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
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" NSNavPanelExpandedStateForSaveMode -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" NSQuitAlwaysKeepsWindows -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" PMPrintingExpandedStateForPrint -bool YES
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" com.apple.swipescrolldirection -bool NO
  sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" com.apple.keyboard.fnState -bool YES
 fi
done

exit 0