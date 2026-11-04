#!/bin/sh

sudo groupdel uinput 2>/dev/null
sudo groupadd --system uinput

sudo usermod -aG input $USER
sudo usermod -aG uinput $USER

sudo modprobe uinput

sudo tee /etc/udev/rules.d/99-input.rules > /dev/null <<EOF
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
EOF

sudo tee /etc/udev/rules.d/99-power-tuning.rules > /dev/null <<EOF
# Internal MT7925 Bluetooth: unused (TP-Link dongle is used), keep it off and let its port suspend
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0489", ATTR{idProduct}=="e111", ATTR{authorized}="0", ATTR{power/control}="auto"

# Runtime PM for all PCI devices (NVMe, Wi-Fi, SPI, eSPI, sensor hub, PMT, DTT, ...)
ACTION=="add", SUBSYSTEM=="pci", ATTR{power/control}="auto"
EOF

sudo udevadm control --reload-rules && sudo udevadm trigger
