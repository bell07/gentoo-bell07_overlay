# Copyright 2020-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KERNEL_IUSE_GENERIC_UKI=1

inherit kernel-build toolchain-funcs

PATCHSET=linux-gentoo-patches-6.18.16
CONFIG_COMMIT="c28a37cee7ea8e0bf2a476f378a1405a7f837ec2"
DEVICE_ARCH=${CHOST%%-*}

DESCRIPTION="The Kernel for Valve SteamDeck built with Gentoo patches"
HOMEPAGE="https://github.com/evlaV/linux-integration"

KERNELVERSION="${PV%.*}"
VALVEVERSION="${PV##*.}"
CONFIGVERSION="${KERNELVERSION%.*}"
CONFIG_VER="${CONFIGVERSION//./}"

SRC_URI+="
	https://github.com/evlaV/linux-integration/archive/refs/tags/${KERNELVERSION}-valve${VALVEVERSION}.zip -> linux-neptune-${PV}.zip
	https://distfiles.gentoo.org/pub/proj/dist-kernel/patchsets/${CONFIGVERSION}/${PATCHSET}.tar.xz
	https://raw.githubusercontent.com/evlaV/jupiter/${CONFIG_COMMIT}/linux-neptune-${CONFIG_VER}/config-neptune -> config-neptune-${CONFIG_VER}-${CONFIG_COMMIT}
	https://raw.githubusercontent.com/evlaV/jupiter/${CONFIG_COMMIT}/linux-neptune-${CONFIG_VER}/config.${DEVICE_ARCH} -> config.${DEVICE_ARCH}-${CONFIG_VER}-${CONFIG_COMMIT}
"
RESTRICT="nomirror"
S="${WORKDIR}"/linux-integration-"${KERNELVERSION}"-valve"${VALVEVERSION}"

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
	eapply "${WORKDIR}/${PATCHSET}"

	default

	# add Extraversion
	local extraversion=."${VALVEVERSION}"-neptune-gentoo-dist
	sed -i -e "s:^\(EXTRAVERSION =\).*:\1 ${extraversion/_/-}:" Makefile || die

	# Enable default config
	cp "${DISTDIR}/config.${DEVICE_ARCH}-${CONFIG_VER}-${CONFIG_COMMIT}" .config  || die
	cat "${DISTDIR}/config-neptune-${CONFIG_VER}-${CONFIG_COMMIT}" >> .config || die

	echo "CONFIG_LOCALVERSION=\"-gentoo-dist\"" > "${T}"/version.config || die

	kernel-build_merge_configs
}
