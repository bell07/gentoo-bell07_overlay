# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit git-r3

KEYWORDS="amd64 arm64"
SLOT="0"

IUSE="l10n_de"

HOMEPAGE="TODO"

DESCRIPTION="Simple Floating Windows Desktop (sfw-desktop)"

EGIT_REPO_URI="https://gitlab.com/bell07/${PN}"
EGIT_BRANCH="master"

RDEPEND="
gnome-extra/nm-applet
gui-wm/labwc
gui-apps/gtklock
gui-apps/kanshi
gui-apps/sfwbar
gui-apps/wlogout
media-libs/libpulse
sys-auth/elogind
sys-power/acpilight
x11-misc/pcmanfm-qt
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
	
	insinto /usr/share/wayland-sessions/
	doins session/sfw-desktop.desktop
	
	# Labwc config
	insinto /etc/xdg
	doins -r labwc

	# Other tools
	insinto /etc/xdg/sfw-desktop
	for file in tool-configs/*; do
		doins "$file"
	done
}
