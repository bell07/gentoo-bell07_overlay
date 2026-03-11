# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KERNEL_IUSE_GENERIC_UKI=1

inherit kernel-build toolchain-funcs
PATCH_PV=${PV%_p*}
PATCHSET=linux-gentoo-patches-6.16.12

CONFIG_VER="616"

DESCRIPTION="The Kernel for Valve SteamDeck built with Gentoo patches"
HOMEPAGE="https://github.com/evlaV/linux-integration"

EXTRAVERSION="-valve10"

SRC_URI+="
	https://github.com/evlaV/linux-integration/archive/refs/tags/${PV}${EXTRAVERSION}.zip -> linux-neptune-${PV}${EXTRAVERSION}.zip
	https://dev.gentoo.org/~mgorny/dist/linux/${PATCHSET}.tar.xz
	https://raw.githubusercontent.com/evlaV/jupiter/refs/heads/main/linux-neptune-${CONFIG_VER}/config -> linux-neptune-${CONFIG_VER}.config
"
RESTRICT="nomirror"
S="${WORKDIR}"/linux-integration-"${PV}${EXTRAVERSION}"

KEYWORDS="-* ~amd64"
IUSE="debug"

BDEPEND="
	debug? ( dev-util/pahole )
"

QA_FLAGS_IGNORED="
	usr/src/linux-.*/certs/*.so
	usr/src/linux-.*/scripts/gcc-plugins/.*.so
	usr/src/linux-.*/vmlinux
"

src_prepare() {
	local patch
	eapply "${WORKDIR}/${PATCHSET}"

	default

	# add Extraversion
	local extraversion=-neptune${EXTRAVERSION}-gentoo-dist
	sed -i -e "s:^\(EXTRAVERSION =\).*:\1 ${extraversion/_/-}:" Makefile || die

	# Enable default config
	cp "${DISTDIR}/linux-neptune-${CONFIG_VER}.config" .config || die

	echo "CONFIG_LOCALVERSION=\"-gentoo-dist\"" > "${T}"/version.config || die

	kernel-build_merge_configs
}
