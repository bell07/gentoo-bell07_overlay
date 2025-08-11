# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Omnissa Horizon Client for Linux"
HOMEPAGE="https://www.omnissa.com/products/horizon-8/"
# Horizon blast does not work"

VER1="CART26FQ2_LIN_2506"
VER2="8.16.0-16536624989"

SRC_URI="https://download3.omnissa.com/software/${VER1}_TARBALL/Omnissa-Horizon-Client-Linux-${PV}-${VER2}.tar.gz"
RESTRICT="mirror"

LICENSE="omnissa"
KEYWORDS="~amd64"
SLOT="0"

S="${WORKDIR}"

inherit xdg

RDEPEND="media-libs/libva-compat[X]
x11-libs/libvdpau
"

src_unpack() {
	unpack "Omnissa-Horizon-Client-Linux-${PV}-${VER2}.tar.gz"
	unpack "Omnissa-Horizon-Client-Linux-${PV}-${VER2}/x64/Omnissa-Horizon-Client-${PV}-${VER2}.x64.tar.gz"
	unpack "Omnissa-Horizon-Client-Linux-${PV}-${VER2}/x64/Omnissa-Horizon-PCoIP-${PV}-${VER2}.x64.tar.gz"
}

src_prepare() {
	cd "${WORKDIR}"/Omnissa-Horizon-Client-"${PV}"-"${VER2}".x64
	# Patch lib dir
	sed -i 's:/usr/lib/:/usr/lib64/:g' usr/bin/*

	eapply_user
}

src_install() {
	cd "${WORKDIR}"/Omnissa-Horizon-Client-"${PV}"-"${VER2}".x64/usr

	for binfile in bin/*; do
		dobin "${binfile}"
	done

	insinto /usr/lib64
	doins lib/libclientSdkCPrimitive.so
	doins -r lib/omnissa
	exeinto /usr/lib64/omnissa/horizon/bin/
	for binfile in lib/omnissa/horizon/bin/*; do
		doexe "${binfile}"
	done

	insinto /usr/share
	doins -r share/applications
	doins -r share/icons
	doins -r share/locale
	doins -r share/pixmaps
	#doins -r share/X11

	dodoc -r share/doc

	cd "${WORKDIR}"/Omnissa-Horizon-PCoIP-"${PV}"-"${VER2}".x64/usr
	insinto /usr/lib64
	doins lib/libpcoip_client.so
	doins -r lib/omnissa
	doins -r lib/pcoip

	exeinto /usr/lib64/omnissa/horizon/client
	doexe lib/omnissa/horizon/client/horizon-protocol
}
