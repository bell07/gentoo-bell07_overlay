# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib unpacker

# check for current version at https://www.ubuntuupdates.org/package/google_chrome/stable/main/base/google-chrome-stable
CHROME_PN="google-chrome-stable"
CHROME_PV="${PV}"
CHROME_P="${CHROME_PN}_${CHROME_PV}-1"
CHROME_DIR="opt/google/chrome/WidevineCdm/_platform_specific/linux_x64"

DESCRIPTION="An adapter for playing DRM content"
HOMEPAGE="https://www.google.com/chrome"
SRC_URI="https://dl.google.com/linux/chrome/deb/pool/main/g/${CHROME_PN}/${CHROME_P}_amd64.deb"

LICENSE="google-chrome"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

DEPEND=""
RDEPEND="
	>=media-tv/kodi-18
"

S="${WORKDIR}/${CHROME_DIR}"

src_install() {
	insinto /usr/$(get_libdir)/kodi/cdm
	doins libwidevinecdm.so
}
