EAPI="7"
KEYWORDS="amd64 arm64"
SLOT="0"

IUSE="binary gaming +portage wayland xfce X l10n_de"
HOMEPAGE="https://gitlab.com/bell07/my-gentoo-config"

DESCRIPTION="My configuration files with preferred settings"

COMMIT="1fb3d6094995e76e529dd192503e139dec47f63a"

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
		insinto /etc/portage
		doins portage/package.nowarn
		insinto /etc/portage/package.accept_keywords
		doins portage/package.accept_keywords/my-portage-config
		if use binary; then
			insinto /etc/portage
			doins -r portage/binrepos.conf
		fi
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
