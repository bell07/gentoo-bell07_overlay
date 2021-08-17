# Copyright 2021 by bell07
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="External Display dock handler script"
HOMEPAGE="https://gitlab.com/bell07/dock-hotplug"

inherit git-r3

EGIT_REPO_URI="https://gitlab.com/bell07/dock-hotplug"
EGIT_BRANCH="master"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="!app-eselect/eselect-nintendo-switch-dock-handler
         app-admin/sudo
         x11-apps/xrandr
         media-sound/pulseaudio"

src_install() {
	dobin dock-hotplug

	insinto /lib/udev/rules.d
	doins 93-dock-hotplug.rules

	insinto /etc
	doins dock-hotplug.env

	insinto /etc/xdg/autostart
	doins dock-hotplug.desktop

	insinto /usr/share/dock-hotplug
	doins -r devices
}

pkg_postinst() {
	elog "To get right setting in lightdm on logout please set"
	elog "    display-setup-script=/usr/bin/dock-hotplug"
	elog "to the /etc/lightdm/lightdm.conf"
}
