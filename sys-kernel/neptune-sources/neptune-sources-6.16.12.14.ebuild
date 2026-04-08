# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"
ETYPE="sources"
K_SECURITY_UNSUPPORTED="1"
K_NOSETEXTRAVERSION="1"

inherit kernel-2 unpacker
detect_version
detect_arch
KERNELVERSION="${PV%.*}"
VALVEVERSION="${PV##*.}"

DESCRIPTION="The Kernel Sources for Valve SteamDeck"
HOMEPAGE="https://github.com/evlaV/linux-integration"

# Needed for zstd compression of the patch
BDEPEND="$(unpacker_src_uri_depends)"

EXTRAVERSION="-valve${VALVEVERSION}"
SRC_URI="https://github.com/evlaV/linux-integration/archive/refs/tags/${KERNELVERSION}-valve${VALVEVERSION}.zip -> linux-neptune-${PV}.zip"
RESTRICT="nomirror"
S="${WORKDIR}"/linux-integration-"${KERNELVERSION}"-valve"${VALVEVERSION}"

KEYWORDS="~amd64"

pkg_setup() {
	ewarn
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn
	ewarn "The original kernel configuration can be found at:"
	ewarn "https://github.com/evlaV/jupiter/blob/main/linux-neptune-616"
	ewarn
	kernel-2_pkg_setup
}


pkg_postrm() {
	kernel-2_pkg_postrm
}
