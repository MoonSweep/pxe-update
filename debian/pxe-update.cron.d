#
# Regular cron job for the pxe-update package
#

MAILTO=root

# Once you have configured /etc/pxe-update/pxe-update.conf to suit your needs,
# uncomment this job to have your PXE server automatically updated every night
#0 4 * * *	pxe-update	[ -x /usr/bin/pxe-update ] && /usr/bin/pxe-update
