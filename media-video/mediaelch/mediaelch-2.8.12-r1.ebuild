EAPI=7
inherit qmake-utils cmake

MY_PN=MediaElch
S=$WORKDIR/$MY_PN-$PV

DESCRIPTION="Video metadata scraper"
HOMEPAGE="http://www.mediaelch.de/"

IUSE="debug"

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/Komet/MediaElch"
	EGIT_BRANCH="master"
	EGIT_SUBMODULES=()
	inherit git-r3
	S="${WORKDIR}/mediaelch-9999"
else
	RESTRICT="mirror"
	SRC_URI="https://github.com/Komet/$MY_PN/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64"
fi


SLOT="0"
LICENSE="LGPL-3"

DEPEND="dev-libs/quazip
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

PATCHES=(
	"${FILESDIR}"/2.8.12-6f9d61569750fd6e3a5dd78985fea20e069c1a1d.patch
	"${FILESDIR}"/2.8.12-3b81667a19be2767d21ac0d50c79c678b8e923e9.patch
)

src_configure() {
	local mycmakeargs=("-DUSE_EXTERN_QUAZIP=ON")
	if use debug; then
		CMAKE_BUILD_TYPE=Debug
		mycmakeargs+=("-DSANITIZE_ADDRESS=on")
		CXXFLAGS+=("-fsanitize=address")
	fi

	cmake_src_configure
}

src_install() {
	cmake_src_install
	cd "${BUILD_DIR}"/src
	dolib.so liblibmediaelch.so
}
