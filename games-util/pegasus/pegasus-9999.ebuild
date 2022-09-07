# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=7

DESCRIPTION="Graphical frontend for browsing your game library"
HOMEPAGE="https://pegasus-frontend.org/"

EGIT_REPO_URI="https://github.com/mmatyas/pegasus-frontend"
EGIT_BRANCH="master"
inherit git-r3


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-qt/qtgraphicaleffects
dev-qt/qtmultimedia[qml]
dev-qt/qtsvg
dev-qt/qtsql[sqlite]
"

#S="${WORKDIR}/tsc-${PV}/tsc"

inherit cmake

#src_configure() {
#	local mycmakeargs=("-DUSE_LIBXMLPP3=ON")
#	cmake_src_configure
#}

src_install() {
	cmake_src_install

	dolib.so ${BUILD_DIR}/assets/libpegasus-assets.so
	dolib.so ${BUILD_DIR}/src/app/libpegasus-locales.so
	dolib.so ${BUILD_DIR}/src/frontend/libpegasus-qml.so
	dolib.so ${BUILD_DIR}/src/backend/libpegasus-backend.so
	dolib.so ${BUILD_DIR}//thirdparty/SortFilterProxyModel/libSortFilterProxyModel.so
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
