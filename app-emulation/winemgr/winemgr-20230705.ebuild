# Copyright 2022 Alexander Weber
# Distributed under the terms of the GNU General Public License v3

EAPI=7

DESCRIPTION="Simple Wine manager for Gentoo"
HOMEPAGE="https://gitlab.com/bell07/winemgr"

COMMIT="28740f8d15eb2bcccc5e7e65915cddf57f103da8"

SRC_URI="${HOMEPAGE}/-/archive/${COMMIT}/winemgr-${COMMIT}.zip -> ${P}.zip"
RESTRICT="mirror"
S="${WORKDIR}/winemgr-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
virtual/wine
app-emulation/winetricks
app-emulation/dxvk
app-emulation/vkd3d-proton
"

src_install() {
	dobin winemgr-build
	dobin winemgr-run

	insinto /etc
	newins winemgr.env.TEMPLATE winemgr.env

	insinto /usr/share/winemgr
	doins winemgr-lib.env

	dodoc README.md
	dodoc winemgr-app.env.TEMPLATE
}
