# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools multilib-minimal

DESCRIPTION="Glide to OpenGL wrapper (Qemu-xtra version)"
HOMEPAGE="http://openglide.sourceforge.net https://github.com/kjliew/qemu-xtra" 

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="+sdl static-libs"

RDEPEND="virtual/glu[${MULTILIB_USEDEP}]
	virtual/opengl[${MULTILIB_USEDEP}]
	sdl? (
		media-libs/libsdl[${MULTILIB_USEDEP}]
	)
	!sdl? (
		x11-libs/libICE[${MULTILIB_USEDEP}]
		x11-libs/libSM[${MULTILIB_USEDEP}]
		x11-libs/libXxf86vm[${MULTILIB_USEDEP}]
	)
	!media-libs/openglide"

DEPEND="${RDEPEND}"

EGIT_REPO_URI="https://github.com/kjliew/qemu-xtra"
EGIT_BRANCH="master"
EGIT_SUBMODULES=()
inherit git-r3
S="${WORKDIR}/${PN}-9999/openglide"

ECONF_SOURCE="${S}"

MULTILIB_WRAPPED_HEADERS=(
	/usr/include/openglide/sdk2_unix.h
)

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	econf \
		--enable-shared \
		--disable-sdltest \
		$(use_enable sdl) \
		$(use_enable static-libs static)
}

multilib_src_install_all() {
	# Drop the libtool file *if* it exists
	# bug #778266
	find "${ED}" -name '*.la' -delete || die

	einstalldocs
}
