# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI="8"
inherit udev xdg

DESCRIPTION="Game launcher and overlay designed with a gamepad native experience in mind."
HOMEPAGE="https://opengamepadui.readthedocs.io"

SRC_URI="https://github.com/ShadowBlip/OpenGamepadUI/releases/download/v${PV}/opengamepadui.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror strip"

LICENSE="GPL-3"
KEYWORDS="amd64"
TEMPLATES_ARCH="x86_64"

SLOT="0"

DEPEND="
dev-libs/libevdev
x11-libs/libX11
x11-libs/libXau
x11-libs/libxcb
x11-libs/libXdmcp
x11-libs/libXext
x11-libs/libXres
"

RDEPEND="${DEPEND}
gui-wm/gamescope[libei]"

S="${WORKDIR}/opengamepadui"

src_compile() {
	einfo "precompiled. nothing to do"
}

src_install() {
	emake PREFIX="${D}"/usr INSTALL_PREFIX="${EROOT}"/usr install
	rm "${D}"/usr/lib/systemd/user/systemd-sysext-updater.service
}
