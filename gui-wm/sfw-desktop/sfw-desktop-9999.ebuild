# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit git-r3

KEYWORDS="amd64 arm64"
SLOT="0"

IUSE="l10n_de upower"

HOMEPAGE="https://gitlab.com/bell07/${PN}"

DESCRIPTION="Simple Floating Windows Desktop (sfw-desktop)"

EGIT_REPO_URI="https://gitlab.com/bell07/${PN}"
EGIT_BRANCH="master"

RDEPEND="
gui-wm/labwc
gui-apps/sfwbar
gui-apps/wlogout
upower? ( sys-power/upower )
"


src_prepare() {
	SINGLE_LANGUAGE="${L10N:-en}"
	sed -i "s:XKB_DEFAULT_LAYOUT=us:XKB_DEFAULT_LAYOUT=$SINGLE_LANGUAGE:g" "${S}"/labwc/environment
	eapply_user
}


src_install() {
	dodoc readme.md

	# session base
	dobin session/start-sfw-desktop

	exeinto /etc/xdg/sfw-desktop
	doexe session/sfw-session

	use upower && doexe session/battery-safe-shutdown.sh

	insinto /usr/share/wayland-sessions/
	doins session/sfw-desktop.desktop

	insinto /etc
	doins -r wlogout

	insinto /etc/xdg
	doins -r kanshi
	doins -r labwc
	doins -r sfwbar
}

pkg_postinst() {
	elog "sfw-desktop uses next software, if installed"
	elog ""
	elog "gnome-extra/nm-applet: Tray icon to configure Network interfaces."
	elog " If you do not like to install it, try the the sfwbar network plugin"
	elog ""
	elog "gui-apps/gtklock: Lock screen"
	elog ""
	elog "gui-apps/swayidle: call gtklock if idle"
	elog ""
	elog "gui-apps/kanshi: Display configuration"
	elog ""
	elog "sys-power/acpilight: Display brightness"
	elog ""
	elog "x11-misc/pcmanfm-qt: Display Icons and Background"
	elog " or"
	elog "gui-apps/swaybg: Background only without icons"
	elog ""
	elog "x11-terms/kitty: Terminal emulator"
	elog ""
	elog "x11-misc/dunst: Notification daemon"
	elog " If you do not like to install it, try the the sfwbar notification plugin"
	elog ""
	elog "gui-apps/grim + gui-apps/slurp + gui-apps/wl-clipboard : Screenshoter on print button"
	elog ""
}

