TODO for pxe-update
====================

pxe-update
-----------

### Fixes
- Fix LMDE quirk (hardcoded release date)

### New features
- Old Ubuntu releases (not sure if it'd be really useful)

Debian package
--------------

- Depends: lftp
- Recommends: tftpd-hpa | atftpd, imagemagick, fuseiso, rsync
- Daily cron job
- Debconf questions to build config file ?
  - PXE_HOME dir (default: /srv/tftp)
  - PXE_BANNER (default: empty string)
  - Default distribs (default: debian:stable)
