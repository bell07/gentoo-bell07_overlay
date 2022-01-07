# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=7

DESCRIPTION="The Secret Chronicles of Dr. M."
HOMEPAGE="https://secretchronicles.org/"
SRC_URI="https://ftp.secretchronicles.org/releases/TSC-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"


DEPEND="media-libs/libsfml
	dev-games/cegui[opengl,devil]
	media-libs/libpng
	dev-libs/libpcre
	dev-cpp/libxmlpp
	dev-libs/boost"

S="${WORKDIR}/TSC-${PV}/tsc"

PATCHES=(
        "${FILESDIR}/missing_include-2.1.0.patch"
)

inherit cmake

src_configure() {
	local mycmakeargs=("-DUSE_LIBXMLPP3=ON")
	cmake_src_configure
}

src_install() {
	cmake_src_install
	rm -r "${D}/usr/share/appdata/"
}

pkg_postinst() {
        xdg_icon_cache_update
}

pkg_postrm() {
        xdg_icon_cache_update
}
