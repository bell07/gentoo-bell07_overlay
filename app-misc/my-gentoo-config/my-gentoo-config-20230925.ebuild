EAPI="7"
KEYWORDS="amd64 arm64"
SLOT="0"

IUSE="gaming +portage wayland xfce X l10n_de"
HOMEPAGE="https://gitlab.com/bell07/my-gentoo-config"

DESCRIPTION="My configuration files with preferred settings"

COMMIT="d5d4fce76e91722b89c31a0426d6645be04599f2"

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

	if use xfce || use wayland; then
		exeinto /usr/share/my-session-scripts
		use xfce && doexe session-scripts/my-xfce-session.sh
		use wayland && doexe session-scripts/my-wayland-session.sh
	fi

	if use X && use l10n_de; then
		insinto /etc/X11/xorg.conf.d/
		doins xorg.conf.d/10-my-keyboard.conf
	fi
}
