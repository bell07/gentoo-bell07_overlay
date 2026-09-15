# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

DESCRIPTION="The powerful and highly customizable scraping-tool to maintain your gamelists"
HOMEPAGE="https://gemba.github.io/skyscraper/"

SRC_URI="https://github.com/Gemba/Skyscraper/archive/refs/tags/${PVR}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

inherit qmake-utils

src_configure() {
	export PREFIX="${EPREFIX}"/usr
	export SYSCONFDIR="${EPREFIX}"/etc
	eqmake6 
}

src_install() {
	emake INSTALL_ROOT="${D}" install

	# Remove Skyscraper Supplementary Scripts
	# Maybe this files should be installed to another place
	rm "${D}"/usr/bin/*.{py,md,sh}   
}
