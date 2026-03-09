# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

DESCRIPTION="Show Files from a Directory on the Desktop"
HOMEPAGE="https://github.com/Geronymos/desktop-icons"

EGIT_REPO_URI="https://github.com/Geronymos/desktop-icons"
EGIT_BRANCH="main"
inherit git-r3


LICENSE="GPL-3"
SLOT="0"

RDEPEND="gui-libs/gtk-layer-shell"
DEPEND="$RDEPEND"

src_install() {
	dobin dicons
	dodoc README.md
}
