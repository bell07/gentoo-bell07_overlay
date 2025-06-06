# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit git-r3

IUSE="binary greetd gaming +portage wayfire X l10n_de"
HOMEPAGE="https://gitlab.com/bell07/my-gentoo-config"

DESCRIPTION="My configuration files with preferred settings"

EGIT_REPO_URI="https://gitlab.com/bell07/${PN}"
EGIT_BRANCH="main"

LICENSE="GPL-3+"
KEYWORDS="amd64 arm64"
SLOT="0"

RDEPEND+=" portage? (
	app-portage/eix
	app-portage/smart-live-rebuild
)"

src_prepare() {
	SINGLE_USER="$(id -nu 1000)"
	sed -i "s:player:$SINGLE_USER:g" "${S}"/greetd/config.toml

	eapply_user
}

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
		dobin portage/gentoo-update.sh
	fi

	if use greetd; then
		exeinto /etc/greetd
		doexe greetd/my-session.sh
		insinto /etc/greetd
		doins greetd/config.toml
	fi

	if use wayfire; then
		insinto /etc/skel/.config
		doins wayfire/wayfire.ini
		doins wayfire/wf-shell.ini

		insinto /usr/share/wayland-sessions/
		doins wayfire/wayfire.desktop
	fi

	if use X && use l10n_de; then
		insinto /etc/X11/xorg.conf.d/
		doins xorg.conf.d/10-my-keyboard.conf
	fi
}
