#!/bin/sh
#* ardon

sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -allowAccessFor -allUsers -access -on -privs -all -clientopts -setvnclegacy -vnclegacy yes

exit 0
