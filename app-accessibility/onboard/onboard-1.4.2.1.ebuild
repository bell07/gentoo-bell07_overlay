# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{8..12} )

inherit distutils-r1 gnome2-utils xdg

DESCRIPTION="An onscreen keyboard useful for tablet PC users and for mobility impaired users"
HOMEPAGE="https://launchpad.net/onboard"
SRC_URI="https://github.com/dr-ni/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"


# po/* are licensed under BSD 3-clause
LICENSE="GPL-3+ BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64"
IUSE="+accessibility debug"

COMMON_DEPEND="app-text/hunspell:=
	dev-libs/dbus-glib
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	dev-python/python-distutils-extra[${PYTHON_USEDEP}]
	gnome-base/dconf
	gnome-base/gsettings-desktop-schemas
	gnome-base/librsvg
	media-libs/libcanberra
	x11-libs/gtk+:3[introspection]
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXtst
	x11-libs/libwnck:3
	x11-libs/pango"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool"
RDEPEND="${COMMON_DEPEND}
	app-text/iso-codes
	accessibility? (
		app-accessibility/at-spi2-core:2
		gnome-extra/mousetweaks
	)
	x11-libs/libxkbfile"

RESTRICT="mirror test"

src_prepare() {
	default
	# Patch documentation paths
	einfo "Patch documentation path in ${S}/setup.py"
	sed -i 's:share/doc/onboard:share/doc/'${P}':g' "${S}/setup.py"
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
