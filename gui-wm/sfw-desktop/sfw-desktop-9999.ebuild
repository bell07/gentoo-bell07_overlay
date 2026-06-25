# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit git-r3 optfeature

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
	optfeature "Tray icon to configure Network interfaces (alternative to sfwbar plugin)" gnome-extra/nm-applet
	optfeature "Lock Screen" gui-apps/gtklock
	optfeature "Auto-lock screen if idle" gui-apps/swayidle
	optfeature "Display configuration" gui-apps/kanshi
	optfeature "Display brightness" sys-power/acpilight
	optfeature "File-Manager" x11-misc/pcmanfm-qt x11-misc/pcmanfm
	optfeature "Desktop icons" x11-misc/pcmanfm-qt
	optfeature "Desktop background image" x11-misc/pcmanfm-qt gui-apps/swaybg
	optfeature "Terminal emulator" x11-terms/kitty
	optfeature "Notification daemon (alternative to sfwbar plugin)" x11-misc/dunst
	optfeature "Screenshoter on print button" "gui-apps/grim gui-apps/slurp gui-apps/wl-clipboard"
}

