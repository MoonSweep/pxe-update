Building instructions
=====================

Building this script needs parts of the GNU Build System:

- GNU Autoconf
- GNU Automake
- GNU Make

It also needs the `sed` command.

This software is built and tested with GNU implementations of `sed` and `make`,
but it should be portable enough to be used with other implementations.

Configuration
-------------

Once the GNU Build system is correctly prepared, to configure it for your
system, run:

`./configure`

This will configure everything correctly for a local installation, that means,
an installation in the "/usr/local" prefix.

If you plan to package the script for a GNU/Linux distribution, your package
build should instead run something like:

`./configure --sysconfdir=/etc --prefix=/usr`

To see all configuration options, run:

`./configure --help`

Build
-----

After a successful configuratiion, run:

`make`

Installation
------------

After a successful build, run:

`make install`

To uninstall, run:

`make uninstall`

Cleaning the build tree
-----------------------

To clean only the built items (for example, if you want to run the `configure`
script with different options), run:

`make clean`

To also clean everything built by the `configure` script (including the
*Makefile*), run:

`make distclean`

Preparing the GNU Build System
------------------------------

If you want (or need) to modify this software more deeply than just modifying
paths or patch a source file (that is, if you modify *configure.ac* and/or
*Makefile.am*), you need to regenerate some autotools files.

To this end, a small script called `autogen` is provided for convenience. It
will correctly clean the build tree and then regenerate all files by running
the `autoreconf` program with the required options.
