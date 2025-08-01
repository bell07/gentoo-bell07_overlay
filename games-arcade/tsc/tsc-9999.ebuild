# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

DESCRIPTION="The Secret Chronicles of Dr. M."
HOMEPAGE="https://secretchronicles.org/"

EGIT_REPO_URI="https://github.com/Secretchronicles/TSC"
EGIT_BRANCH="devel"
EGIT_SUBMODULES=( '*' '-shared-modules' '-flatpak/shared-modules' )

inherit git-r3


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+expat"

RDEPEND="
	dev-libs/libpcre
	dev-cpp/libxmlpp:2.6
	media-libs/devil
	media-libs/glew
	media-libs/glm
	<media-libs/libsfml-3
	media-libs/libpng
	virtual/opengl
"

DEPEND="${RDEPEND}
	dev-libs/boost"

BDEPEND="sys-devel/bison
	dev-lang/ruby"

S="${WORKDIR}/tsc-${PV}/tsc"

inherit cmake

src_configure() {
	local mycmakeargs=(
		-DUSE_LIBXMLPP3=OFF
		-DCEGUI_USE_EXPAT=$(usex expat)
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	rm -r "${D}/usr/share/appdata/"
	rm -r "${D}/usr/share/doc/tsc/"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
