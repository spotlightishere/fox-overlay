# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit unpacker xdg

DESCRIPTION="Reverse engineering tool for Intel and ARM executables (binary package)"
HOMEPAGE="https://www.hopperapp.com"
SRC_URI="https://d2ap6ypl1xbe4k.cloudfront.net/Hopper-v4-${PV}-Linux-demo.deb"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="splitdebug"

# Mirrored from the depends listed in Debian packaging.
RDEPEND="
	dev-libs/libgcrypt
	dev-libs/libbsd
	sys-libs/ncurses
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtnetwork:5
	dev-libs/libxml2
	x11-misc/xdg-utils
"

QA_PREBUILT="
	opt/hopper-v4/bin/Hopper
	opt/hopper-v4/lib/libBlocksRuntime.so.0
	opt/hopper-v4/lib/libdispatch.so.0.1.3.1
	opt/hopper-v4/lib/libffi.so.7
	opt/hopper-v4/lib/libgnustep-base.so.1.27.0
	opt/hopper-v4/lib/libHopperCore.so
	opt/hopper-v4/lib/libkqueue.so.0
	opt/hopper-v4/lib/libobjc.so.4.6
	opt/hopper-v4/lib/libpthread_workqueue.so.0
"

src_prepare() {
	default
}

src_install() {
	mv usr/share/doc/hopperv4 usr/share/doc/${PF} || die

	insinto /
	doins -r usr
	doins -r opt
	local f
	for f in ${QA_PREBUILT}; do
		fperms +x "/${f}"
	done

	dosym ../../opt/hopper-v4/bin/Hopper /usr/bin/Hopper
}

pkg_postinst() {
	xdg_pkg_postinst
}

