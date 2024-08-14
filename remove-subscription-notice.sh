#!/bin/bash

# remove subscription notice
# run it once after installation and after each update
# creates a backup of the original file by appending the extension .bak

if grep --quiet "orig_cmd();return;" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js; then
        echo "fixed already, nothing to do"
else
        date = $(date +%Y%m%d%H%M%S)
        sed --regexp-extended --null-data --in-place="${date}.bak" "s/(function\(orig_cmd\) \{)/\1\n\torig_cmd\(\);return;/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js
        echo "function fixed, restarting pveproxy.service"
        systemctl restart pveproxy.service
fi
