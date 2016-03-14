

### Serial Pinout

||WAN|LAN1|LAN2|LAN3|LAN4|Power|
|---|---|---|---|---|---|---|
|USB|||||||
|**VCC**|||||||
|**GND**|||||||
|**RX**|||||||
|**TX**|||||||

### Download Firmware

Download firmware without bootloader from [this link](https://github.com/minhazul-haque/OpenWRT-TL-MR3420/raw/master/mr3420-v2-noboot.bin). Copy it as `/tftpboot/firmware.bin`.

### Install TFTP and TFTPD

Run `sudo apt-get install tftp tftpd`

### Configure TFPD

Add the following lines to `/etc/xinetd.d/tftp`.

```
service tftp
{
protocol        = udp
port            = 69
socket_type     = dgram
wait            = yes
user            = nobody
server          = /usr/sbin/in.tftpd
server_args     = /tftpboot
disable         = no
}
```

Then restart tftpd `sudo service tftpd restart`.

### Setup Ethernet Port

Set eht0 of your PC with IP 192.168.1.111.

`sudo ifconfig eht0 192.168.1.111 up`

### Flash Recovery Firmware

Into serial console, write the following.

```
erase 0x9f020000 +0x3c0000
tftpboot 0x81000000 firmware.bin
cp.b 0x81000000 0x9f020000 0x3c0000
bootm 0x9f020000
```
