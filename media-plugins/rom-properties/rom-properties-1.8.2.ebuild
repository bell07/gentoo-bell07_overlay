EAPI="7"

inherit cmake-utils

DESCRIPTION="This shell extension adds a few nice features to file browsers for managing video game ROM and disc images"
HOMEPAGE="https://github.com/GerbilSoft/rom-properties"
LICENSE="GPL-2"

SLOT="0"

IUSE="thunar"

DEPEND="thunar? ( xfce-extra/tumbler[curl] )"

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/GerbilSoft/${PN}.git"
	inherit git-r3
else
	RESTRICT="mirror"
	SRC_URI="https://github.com/GerbilSoft/rom-properties/archive/v${PV}.zip -> ${P}.zip"
	KEYWORDS="~amd64"
fi

src_configure() {
	sed -i 's:SET(DIR_INSTALL_DOC "share/doc/${PACKAGE_NAME}"):SET(DIR_INSTALL_DOC "'share/doc/${PF}'"):g' "${S}"/cmake/macros/DirInstallPaths.cmake 
	local mycmakeargs=( -DSPLIT_DEBUG=0 )
	cmake-utils_src_configure
}

pkg_postinst() {
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
}
