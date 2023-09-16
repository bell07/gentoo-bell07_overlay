# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

DESCRIPTION="A powerful and versatile yet easy to use game scraper"
HOMEPAGE="https://github.com/muldjord/skyscraper"

SRC_URI="https://github.com/muldjord/${PN}/archive/refs/tags/${PVR}.zip"
RESTRICT="mirror"

inherit qmake-utils


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-qt/qtcore
	dev-qt/qtnetwork
	dev-qt/qtxml"

DEPEND="${RDEPEND}"

src_configure() {
	eqmake5
}

src_install() {
	dobin Skyscraper
	dodoc README.md
}
