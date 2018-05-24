#!/bin/sh
# Setup a scenario VM. Use this with the -c/--script-chroot flag.
# This serves about the same purpose as mkosi.postinst/mkosi.extra.

# Use arguments or environment variables
: ${PASSWORD:=$1}
: ${HOSTNAME:=$2}
# Fallback values
: ${PASSWORD:='changeme'}
: ${HOST:='example-scenario'}

# Initial system setup
echo "root:$PASSWORD" | /usr/sbin/chpasswd
setup-keymap us us
setup-timezone -z Europe/Berlin
setup-hostname -n $HOST
setup-interfaces -i <<EOF
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
	hostname $HOST
EOF

# enable networking and urandom on boot
rc-update add networking boot
rc-update add urandom boot
# react to ACPI events sent by the hypervisor
rc-update add acpid default
# enable ssh server if installed
rc-update add dropbear default 2>/dev/null || true
rc-update add sshd default 2>/dev/null || true

# shorten 3s boot delay to 0.1s
sed -i -e 's/TIMEOUT 30/TIMEOUT 1/' /boot/extlinux.conf
# make sure to forbid password logins via dropbear
# (openssh already has this for root by default)
set -i -e 's/DROPBEAR_OPTS=""/DROPBEAR_OPTS="-s"/' /etc/conf.d/dropbear 2>/dev/null || true

rm /etc/motd
####################################################################
# Add your stuff here!
# You are currently chroot'ed into the image and at `/mnt`, which is
# bound to the directory of this script on your host. Install all
# files necessary for the scenario into the correct locations now,
# because this `/mnt` won't be in the deployed image.

# Example:
#  - etc/init.d/example -- service init script
#  - opt/example/example.py -- scenario script
adduser -S -H -h /opt/example example
# copy all scenario sub-folders to / (excluding this script)
find . -type d -mindepth 1 -maxdepth 1 -exec cp -r -- {} / \;
# add scenario openrc init file to default runlevel
rc-update add example default

# optionally wait here to chroot into the image before unmounting
#read -p "Press any key to unmount image"
