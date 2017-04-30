# OpenWRT-TL-MR3420

Follow [obtain.firmware.generate](http://wiki.openwrt.org/doc/howto/obtain.firmware.generate) guide to customize and build OpenWRT images.

Built using the following `make` command.

```bash
make image PROFILE=TLMR3420 PACKAGES="kmod-usb-net kmod-usb-net-rndis kmod-usb-net-cdc-ether usbutils udev nano -kmod-ipv6"
```

A version with MQTT broker and other handy utilities can be built with the following command.

```bash
make image PROFILE=TLMR3420 PACKAGES="-kmod-ipv6 nano mosquitto kmod-usb-storage vsftpd unzip lua lua-mosquitto lua-cjson mosquitto-client kmod-fs-vfat kmod-fs-ntfs kmod-fs-ext4 uhttpd-mod-lua"
```

## Features

* Contains `kmod-usb-net kmod-usb-net-rndis kmod-usb-net-cdc-ether usbutils udev` packages for Ethernet over USB modems
* Disabled IPv6 modules and packages
* Nano comes preinstalled

## Install

Upgrade from already installed OpenWRT version ...

`mtd -r write openwrt-15.05-ar71xx-generic-tl-mr3420-v2-squashfs-sysupgrade.bin firmware`

Or use TL-MR3420 Web UI to flash the following image ...

`openwrt-15.05-ar71xx-generic-tl-mr3420-v2-squashfs-factory.bin`

## Configure USB Modem with DHCP

Configure USB modems using `uci` ...

    uci set network.wan.ifname=eth2 # eth2/usb0 or whatever
    uci set network.wan.mtu='1400'
    uci commit
    /etc/init.d/network reload
