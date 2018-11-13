#
# Process this file with automake to produce a Makefile.in template.
#

#
# Installation directories
#

pkgsysconfdir = $(sysconfdir)/$(PACKAGE)
customdir = $(pkgsysconfdir)/boot-screens.d
themesdir = $(pkgdatadir)/themes
defaultthemedir = $(themesdir)/default


#
# Common
#

# Command to substitute variables
do_subst = $(SED) \
	-e 's,[@]PACKAGE[@],$(PACKAGE),g' \
	-e 's,[@]VERSION[@],$(VERSION),g' \
	-e 's,[@]pkgsysconfdir[@],$(pkgsysconfdir),g' \
	-e 's,[@]pkgdatadir[@],$(pkgdatadir),g'


#
# Scripts
#

# Main script
bin_SCRIPTS = src/pxe-update

# Initialize source dir
src/.dirstamp:
	$(MKDIR_P) src
	: > $@

# Substitute variables in scripts
$(bin_SCRIPTS): src/.dirstamp Makefile
	$(do_subst) $(srcdir)/$@.in > $@
	chmod +x $@

# Per-script prerequisites
src/pxe-update: src/pxe-update.in


#
# Configuration files
#

# System config file
dist_pkgsysconf_DATA = etc/$(PACKAGE).conf

# Custom boot screens
dist_custom_DATA = etc/boot-screens.d/README


#
# Data
#

# Default theme
dist_defaulttheme_DATA = data/themes/default/stdmenu.cfg data/themes/default/splash.png


#
# Documentation
#

# Manual pages
man_MANS = man/pxe-update.1 man/pxe-update.conf.5

# Initialize manpages dir
man/.dirstamp:
	$(MKDIR_P) man
	: > $@

# Substitute variables in manpages
$(man_MANS): man/.dirstamp Makefile
	$(do_subst) $(srcdir)/$@.in > $@

# Per-manpage prerequisites
man/pxe-update.1: man/pxe-update.1.in
man/pxe-update.conf.5: man/pxe-update.conf.5.in

# Non-standard documentation files
dist_doc_DATA = README.md TODO.md


#
# Uninstall hook to remove empty directories
#

uninstall-hook:
	if test -d $(DESTDIR)/$(customdir) ; then rmdir $(DESTDIR)/$(customdir) ; fi
	if test -d $(DESTDIR)/$(pkgsysconfdir) ; then rmdir $(DESTDIR)/$(pkgsysconfdir) ; fi
	if test -d $(DESTDIR)/$(docdir) ; then rmdir $(DESTDIR)/$(docdir) ; fi
	if test -d $(DESTDIR)/$(defaultthemedir) ; then rmdir $(DESTDIR)/$(defaultthemedir) ; fi
	if test -d $(DESTDIR)/$(themesdir) ; then rmdir $(DESTDIR)/$(themesdir) ; fi
	if test -d $(DESTDIR)/$(pkgdatadir) ; then rmdir $(DESTDIR)/$(pkgdatadir) ; fi


#
# Distribution
#

# Files to distribute
EXTRA_DIST = autogen BUILD.md LICENSE src/pxe-update.in man/pxe-update.1.in man/pxe-update.conf.5.in

# Files to clean
CLEANFILES = $(bin_SCRIPTS) $(man_MANS) src/.dirstamp man/.dirstamp
