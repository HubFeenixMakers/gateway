# README

python3 remote_command_execution_vulnerability.py

curl http://rubydesign.fi/openwrt-21.02.2-ramips-mt7621-xiaomi_mi-router-4a-gigabit-squashfs-sysupgrade.bin --output firmware.bin

mtd -e OS1 -r write firmware.bin OS1 # Install OpenWrt
