#!/bin/sh
#* ardoff

sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -allowAccessFor -allUsers -access -on -privs -GenerateReports -ChangeSettings -SendFiles -TextMessages -DeleteFiles -clientopts -setvnclegacy -vnclegacy no -setreqperm -reqperm yes -setmenuextra -menuextra yes
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -restart -agent

exit 0
