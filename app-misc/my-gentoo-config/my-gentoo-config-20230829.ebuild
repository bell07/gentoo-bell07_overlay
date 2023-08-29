EAPI="7"
KEYWORDS="amd64 arm64"
SLOT="0"

IUSE="gaming +portage wayland xfce"
HOMEPAGE="https://gitlab.com/bell07/my-gentoo-config"

DESCRIPTION="My configuration files with preferred settings"

COMMIT="534f696d252b90af05c32087458efe22bacc50f5"

SRC_URI="${HOMEPAGE}/-/archive/${COMMIT}/my-gentoo-config-${COMMIT}.zip -> ${P}.zip"
RESTRICT="mirror"
S="${WORKDIR}/my-gentoo-config-${COMMIT}"

src_install() {
	insinto /etc
	if use gaming; then
		doins -r security
		doins -r sysctl.d
	fi

	if use portage; then
		doins -r portage
	fi

	exeinto /usr/share/my-session-scripts
	use xfce && doexe session-scripts/my-xfce-session.sh
	use wayland && doexe session-scripts/my-wayland-session.sh
}
