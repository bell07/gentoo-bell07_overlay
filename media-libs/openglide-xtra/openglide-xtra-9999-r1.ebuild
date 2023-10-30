# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Glide to OpenGL wrapper (Qemu-xtra version)"
HOMEPAGE="http://openglide.sourceforge.net https://github.com/kjliew/qemu-xtra" 

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+sdl static-libs"

RDEPEND="virtual/glu
	virtual/opengl
	sdl? (
		media-libs/libsdl
	)
	!sdl? (
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libXxf86vm
	)
	!media-libs/openglide"

DEPEND="${RDEPEND}"

EGIT_REPO_URI="https://github.com/kjliew/qemu-xtra"
EGIT_BRANCH="master"
EGIT_SUBMODULES=()
inherit git-r3
S="${WORKDIR}/${PN}-9999/openglide"

ECONF_SOURCE="${S}"


src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--enable-shared \
		--disable-sdltest \
		$(use_enable sdl) \
		$(use_enable static-libs static)
}

src_install() {
	default
#	# Drop the libtool file *if* it exists
#	# bug #778266
	find "${ED}" -name '*.la' -delete || die

}
