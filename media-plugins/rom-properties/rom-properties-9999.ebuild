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
	SRC_URI="https://github.com/GerbilSoft/rom-properties/archive/v${PV}.zip -> ${P}.zip"
	KEYWORDS="~amd64"
fi

if [[ ${PV} == 1.6.1 ]] ; then
	PATCHES=( "${FILESDIR}"/79e2c454b7f22847e1ac86d877669c567d127dcb.patch )
fi
