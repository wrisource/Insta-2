#!/bin/bash
#* LoginHook
#+ chris.gerke@gmail.com
#+
#+ Description: Payload required. Setup PostBuild.
#+
#+ Version: 1.0
#+
#+ History:
#+     1.0: Script.
#+
#+ TODO:
#+     * Add error checking?

WORKING_DIR=$(/usr/bin/dirname "${0}")

SERIAL=$(/usr/sbin/ioreg -c IOPlatformExpertDevice | /usr/bin/sed -E -n -e '/IOPlatformSerialNumber/{s/^.*[[:space:]]"IOPlatformSerialNumber" = "(.+)"$/\1/p;q;}')
MACADDRESS=$(/usr/sbin/networksetup -getMACADDRESS en0 | /usr/bin/awk '{print $3}' | /usr/bin/sed s/://g)

ADMIN="ard"
ADMINHOME="/var/ard"

#+ Insta fix
sudo chown root:admin /

#+ UUID
if [[ `ioreg -rd1 -c IOPlatformExpertDevice | /usr/bin/grep -i "UUID" | cut -c27-50` == "00000000-0000-1000-8000-" ]]; then
 UUID=`ioreg -rd1 -c IOPlatformExpertDevice | /usr/bin/grep -i "UUID" | cut -c51-62 | awk {'print tolower()'}`
elif [[ `ioreg -rd1 -c IOPlatformExpertDevice | /usr/bin/grep -i "UUID" | cut -c27-50` != "00000000-0000-1000-8000-" ]]; then
 UUID=`ioreg -rd1 -c IOPlatformExpertDevice | /usr/bin/grep -i "UUID" | cut -c27-62`
fi

#+ Install PKGs
for i in `ls ${WORKING_DIR}/LoginHook | /usr/bin/grep ".pkg"`
do
 sudo installer -pkg "${WORKING_DIR}/LoginHook/${i}" -target /
done

#+ Install MPKGs
for i in `ls ${WORKING_DIR}/LoginHook | /usr/bin/grep ".mpkg"`
do
 sudo installer -pkg "${WORKING_DIR}/LoginHook/${i}" -target /
done

#+ Execute scripts
for i in `ls "${WORKING_DIR}/LoginHook" | /usr/bin/grep ".bash"`
do
 sudo "${WORKING_DIR}/LoginHook/${i}"
done

#+ Execute scripts
for i in `ls "${WORKING_DIR}/LoginHook" | /usr/bin/grep ".sh"`
do
 sudo "${WORKING_DIR}/LoginHook/${i}"
done

#+ Add profiles for laptops
#/usr/sbin/system_profiler SPHardwareDataType | /usr/bin/grep "Model Identifier" | /usr/bin/grep "Book"
#if [ "$?" = "0" ]; then
 for i in `ls "${WORKING_DIR}/LoginHook" | /usr/bin/grep ".mobileconfig"`
 do
  sudo /usr/bin/profiles -I -F "${WORKING_DIR}/LoginHook/${}i"
 done
#fi

sudo /usr/sbin/scutil --set ComputerName "${SERIAL}-${MACADDRESS}"
sudo /usr/sbin/scutil --set LocalHostName "${SERIAL}-${MACADDRESS}"
sudo /usr/sbin/scutil --set HostName "${SERIAL}-${MACADDRESS}"
sudo /bin/hostname "${SERIAL}-${MACADDRESS}"
sudo /usr/bin/defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName "${SERIAL}"

#+ Network, booted volume only
sudo /usr/sbin/networksetup -ordernetworkservices "Ethernet" "Wi-Fi" "FireWire"
sudo /usr/sbin/networksetup -ordernetworkservices "Ethernet" "Wi-Fi" "FireWire" "Bluetooth DUN"
sudo /usr/sbin/networksetup -ordernetworkservices "Ethernet" "Wi-Fi" "FireWire" "Bluetooth DUN" "Bluetooth PAN"
sudo /usr/sbin/networksetup -ordernetworkservices "Ethernet" "Airport" "FireWire"
sudo /usr/sbin/networksetup -ordernetworkservices "Ethernet" "Airport" "FireWire" "Bluetooth DUN"
sudo /usr/sbin/networksetup -ordernetworkservices "Ethernet" "Airport" "FireWire" "Bluetooth DUN" "Bluetooth PAN"
sudo /usr/sbin/networksetup -setv6off "Airport"
sudo /usr/sbin/networksetup -setv6off "Bluetooth Dun"
sudo /usr/sbin/networksetup -setv6off "Bluetooth Pan"
sudo /usr/sbin/networksetup -setv6off "Ethernet"
sudo /usr/sbin/networksetup -setv6off "FireWire"
sudo /usr/sbin/networksetup -setv6off "Wi-Fi"
sudo /usr/sbin/networksetup -setnetworkserviceenabled "Bluetooth DUN" "off"
sudo /usr/sbin/networksetup -setnetworkserviceenabled "Bluetooth PAN" "off"
sudo /usr/sbin/networksetup -setnetworkserviceenabled "FireWire" "off"
sudo /usr/sbin/networksetup -setairportpower "en1" "off"

#+ Power Management, booted volume only
sudo /usr/sbin/systemsetup -setcomputersleep "60"
sudo /usr/sbin/systemsetup -setdisplaysleep "15"
sudo /usr/sbin/systemsetup -setharddisksleep off

#* Disable spotflight for this session
sudo /usr/bin/mdutil -a -i off

#+ Dock reset
/usr/local/bin/dockreset

#* Link to Localiser.
sudo /bin/ln -s "/Library/RDA/Scripts/Localiser.app" "${TARGET_DIR}/${ADMINHOME}/Desktop/Localiser"

#* Link to ID change.
sudo /bin/ln -s "/Library/RDA/Scripts/Tools/ADMitMacIDtoAppleID_BETA.command" "${TARGET_DIR}/${ADMINHOME}/Desktop/ADmitMactoAppleID"

#* Link to AD.
sudo /bin/ln -s "/Library/RDA/Scripts/Tools/ADRebindOnly.command" "${TARGET_DIR}/${ADMINHOME}/Desktop/ADRebindOnly"

#+ Finder
sudo /usr/bin/defaults write "${TARGET_DIR}/${ADMINHOME}/Library/Preferences/com.apple.finder" ShowHardDrivesOnDesktop -bool YES
sudo /usr/bin/defaults write "${TARGET_DIR}/${ADMINHOME}/Library/Preferences/com.apple.finder" FXDefaultSearchScope -string SCcf

#+ CrashReporter
sudo /bin/rm -f "${TARGET_DIR}/${ADMINHOME}/Library/Preferences/com.apple.CrashReporter.plist"

#+ System
sudo /bin/rm -f "${TARGET_DIR}/${ADMINHOME}/Library/Preferences/com.apple.systempreferences.plist"

#+ MenuExtras

#+ Permissions
sudo /usr/sbin/chown -R "${ADMIN}:staff" "${TARGET_DIR}/${ADMINHOME}"
sudo /bin/chmod -R 755 "${TARGET_DIR}/${ADMINHOME}"

#+ Self destruct?
sudo /bin/rm -Rf "${WORKING_DIR}/LoginHook"
sudo /usr/bin/srm "$0"