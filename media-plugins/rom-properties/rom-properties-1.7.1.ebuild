EAPI="7"

inherit cmake-utils

DESCRIPTION="This shell extension adds a few nice features to file browsers for managing video game ROM and disc images"
HOMEPAGE="https://github.com/GerbilSoft/rom-properties"
LICENSE="GPL-2"

SLOT="0"

IUSE="thunar seccomp_debug"
DEPEND="thunar? ( xfce-extra/tumbler[curl] )"

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/GerbilSoft/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/GerbilSoft/rom-properties/archive/v${PV}.zip -> ${P}.zip"
	KEYWORDS="~amd64"
fi

src_configure() {
	if use seccomp_debug; then
		local mycmakeargs=( -DENABLE_SECCOMP_DEBUG=1 )
	fi
	cmake-utils_src_configure
}
