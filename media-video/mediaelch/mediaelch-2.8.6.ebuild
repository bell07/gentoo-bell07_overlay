EAPI=7
inherit qmake-utils cmake

MY_PN=MediaElch
S=$WORKDIR/$MY_PN-$PV

DESCRIPTION="Video metadata scraper"
RESTRICT="mirror"
SRC_URI="https://github.com/Komet/$MY_PN/archive/v${PV}.tar.gz -> $P.tar.gz"
HOMEPAGE="http://www.mediaelch.de/"

SLOT="0"
LICENSE="LGPL-3"
KEYWORDS="amd64"

DEPEND="=dev-libs/quazip-0.9*
	dev-qt/qtconcurrent:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtxmlpatterns:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	media-video/mediainfo
	media-libs/libzen
	media-libs/phonon"

src_configure() {
	local mycmakeargs=( "-DUSE_EXTERN_QUAZIP=ON" )
	cmake_src_configure
}

src_install() {
	cmake_src_install
	cd "${BUILD_DIR}"/src
	dolib.so liblibmediaelch.so
}
