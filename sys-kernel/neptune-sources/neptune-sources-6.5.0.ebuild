# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"

inherit kernel-2 unpacker
detect_version
detect_arch

DESCRIPTION="The Kernel Sources for Valve SteamDeck"
HOMEPAGE="https://gitlab.com/evlaV/linux-integration"

# Needed for zstd compression of the patch
BDEPEND="$(unpacker_src_uri_depends)"

EXTRAVERSION="-valve22"
SRC_URI="https://gitlab.com/evlaV/linux-integration/-/archive/${PV}${EXTRAVERSION}/linux-integration-${PV}${EXTRAVERSION}.zip -> linux-neptune-${PV}${EXTRAVERSION}.zip"
RESTRICT="nomirror"
S="${WORKDIR}"/linux-integration-"${PV}${EXTRAVERSION}"

KEYWORDS="~amd64"

pkg_setup() {
	ewarn
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn
	ewarn "The original kernel configuration can be found at:"
	ewarn "https://gitlab.com/evlaV/jupiter-PKGBUILD/-/tree/master/linux-neptune-65"
	ewarn
	kernel-2_pkg_setup
}


pkg_postrm() {
	kernel-2_pkg_postrm
}
