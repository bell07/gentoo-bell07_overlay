EAPI="7"

inherit cmake-utils

KEYWORDS="~amd64"
SLOT="0"

DESCRIPTION="This shell extension adds a few nice features to file browsers for managing video game ROM and disc images"
HOMEPAGE="https://github.com/GerbilSoft/rom-properties"

SRC_URI="https://github.com/GerbilSoft/rom-properties/archive/v${PV}.zip -> ${P}.zip"
LICENSE="GPL-2"

DEPEND=""

PATCHES=(
	"${FILESDIR}"/79e2c454b7f22847e1ac86d877669c567d127dcb.patch
)
