EAPI="7"
KEYWORDS="amd64 arm64"
SLOT="0"

IUSE="gaming +portage wayland xfce X l10n_de"
HOMEPAGE="https://gitlab.com/bell07/my-gentoo-config"

DESCRIPTION="My configuration files with preferred settings"

COMMIT="4a3dffc8ee1940340119eeb39c7276d8698905a3"

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

	if use xfce; then
		exeinto /etc/my-session-scripts
		doexe session-scripts/my-xfce-session.sh
	fi

	if use wayland; then
		exeinto /etc/my-session-scripts
		doexe session-scripts/my-wayland-session.sh

		insinto /usr/share/wayland-sessions/
		doins session-scripts/my-wayland-session.desktop

		insinto /etc/skel/.config
		doins wayfire/wayfire.ini
		doins wayfire/wf-shell.ini
	fi

	if use X && use l10n_de; then
		insinto /etc/X11/xorg.conf.d/
		doins xorg.conf.d/10-my-keyboard.conf
	fi
}
