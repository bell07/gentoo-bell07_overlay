# Copyright 2022 Alexander Weber
# Distributed under the terms of the GNU General Public License v3

EAPI=7

DESCRIPTION="Simple Wine manager for Gentoo"
HOMEPAGE="https://gitlab.com/bell07/winemgr"

EGIT_REPO_URI="https://gitlab.com/bell07/winemgr"
EGIT_BRANCH="master"
inherit git-r3

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
