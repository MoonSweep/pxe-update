pxe-update
===========

Description
-----------
pxe-update is a shell script to automate maintenance of a PXE server. It's
meant to be run via a daily cron job.

Basically, it downloads netboot images of Debian-based distributions to the
configured TFTP directory (typically /srv/tftp), and builds PXE menu files to
present the available releases in a nice nested menu. However, advanced
configuration allows one to do more, like:

* BIOS or UEFI boot
* Live CD boot via NFS
* Customizable keymap
* Customizable graphical theme

See the pxe-update.conf (5) manpage for all supported features.

Usage
-----
```
pxe-update [OPTION]... [DISTRIBUTION:CODENAME|SUITE]...

OPTIONS:
  -r	Remove unrequested distributions.
  -v	Verbose mode.
  -d	Debug mode.
  -h	Print this help message.

Each argument is a release to download. A release takes the form of a
DISTRIBUTION, followed by a colon, followed by a CODENAME or a SUITE.

DISTRIBUTION can be "debian", "ubuntu" or "mint".
CODENAME is a one-word release codename like "wheezy", "raring" or "sarah"
SUITE is a suite name like "stable" or "devel". Valid suite names are:

Debian: "stable", "testing", "unstable" "oldstable" and "oldoldstable".
Ubuntu: "stable", "devel" (or "unstable"), "oldstable", "lts" and "oldlts".
Mint: "stable" and "lmde".
```

If proprerly configured through the configuration file, it can be just called
as-is without any options, and it will do everything automagically (except
downloading ISO images; also note that Linux Mint doesn't release netboot
images, and thus supports only ISO mode).

Caveats
-------
pxe-update uses the SYSLINUX elements from the "main" release (the first one),
and since Linux Mint doesn't release netboot images, the first release must be
"debian" or "ubuntu".

Be aware that pxe-update downloads _a lot_ from Internet. If you have a
limited data plan, be _very_ careful of the amount of data downloaded every
time the program is run.

For this very reason, it is a deliberate choice from the author **not to**
automatically download Live CD images, and delegate the responsibilty of
managing the Live CD repository to the user.

Also, since all the data is updated every time, even when the files don't
change, their timestamp is still updated; if you have a snapshot-based backup
policy, you may want to exclude the whole TFTP directory from your backups
(since everything can be easily recovered from Internet anyway).

Dependencies
------------
pxe-update needs **lftp** and **shell-script-helper**. Those are hard
dependencies, the script can't work without them.

Unless the TFTP directory is intended to be exported to another host (in the
case of a DMZ for example), you will obviously need a TFTP server like
**tftpd-hpa** or **atftpd** to serve the files to clients.

Additionally, to use the Live CD boot feature, the script needs **fuseiso**
(_not_ fuseiso9660). It also uses **rsync** to avoid copying already up-to-date
files (without it, the script will use **cp**, which will blindly copy
everything).

To process old releases (before Debian Wheezy), the script uses **identify** and
**convert** from **imagemagick** to resize the splash screens (without them, the
splash screens will look distorted).

UEFI boot
---------
UEFI boot is still quite rudimentary, but works. It's only available for the
first release listed, and only if it's a Debian release greater or equal than 8
(Jessie). If this condition is met, it's automatically enabled, there is nothing
else to do.

Keyboard mapping
----------------
To customize the keyboard mapping for BIOS boot (which uses **PXELINUX**),
you'll need the **keytab-lilo** tool (distributed with **LILO**), and keyboard
mappings from **console-data**. Here's an example for a french keyboard:

`keytab-lilo fr > fr.ktl`

For UEFI boot (which uses **GRUB**), you'll need the **grub-kbdcomp** tool
(distributed with **GRUB**), and the keyboard mappings from **xkb**:

`grub-kbdcomp -o fr.gkb fr`

Both tools are normally able to find the source keyboard mappings on their own.
For more information, please refer to their respective documentation.

DHCP server configuration
-------------------------
Here are two examples showing how to configure **ISC DHCP server** for PXE
boot. If you use another DHCP server, please refer to its own documentation.

If you don't care about UEFI boot, the configuration is very simple and consists
of two lines (of course, replace 192.168.1.1 by your own TFTP server's IP
address):

```
# PXE server address
next-server 192.168.1.1;

# BOOTP file
filename "pxelinux.0";
```

To enable both BIOS and UEFI boot, the configuration is slightly longer. When
a client sends a DHCP request, it normally include its architecture type, which
allows the DHCP server to act on it and send the right filename in the answer.
Such a configuration can be written like that:

```
# PXE server address
next-server 192.168.1.1;

# BIOS/UEFI BOOTP files
option arch code 93 = unsigned integer 16;
if option arch = 00:00 {
  filename "pxelinux.0";
} elsif option arch = 00:06 {
  filename "bootnetia32.efi";
} elsif option arch = 00:07 or option arch = 00:09 {
  filename "bootnetx64.efi";
}
```

If you need to support other (less common) hardware, please refer to RFC 4578
for other supported architecture types.

Credits
-------
Copyright © 2018 Raphaël Halimi <raphael.halimi@gmail.com>

License
-------
Everything in this distribution is licensed under the GNU General Public License
version 3 or later.
