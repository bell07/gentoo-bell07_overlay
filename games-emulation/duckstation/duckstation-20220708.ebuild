# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg cmake desktop

DESCRIPTION="Fast Sony PlayStation (PSX) emulator"
HOMEPAGE="https://github.com/stenzek/duckstation"

VERSION_COMMIT="82965f741e81e4d2f7e1b2abdc011e1f266bfe7f"
SRC_URI="https://github.com/stenzek/duckstation/archive/${VERSION_COMMIT}.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"
IUSE="discord +egl +evdev fbdev +gamepad gbm +nogui qt5 retroachievements wayland X"

# Either or both frontends must be built
REQUIRED_USE="
	?? ( fbdev gbm )
	gbm? ( egl )
	wayland? ( egl )
"

BDEPEND="
	virtual/pkgconfig
	wayland? ( kde-frameworks/extra-cmake-modules )
"
DEPEND="
	evdev? ( dev-libs/libevdev )
	gamepad? ( media-libs/libsdl2 )
	gbm? ( x11-libs/libdrm )
	qt5? (
			dev-qt/qtcore
			dev-qt/qtgui
			dev-qt/qtnetwork
	)
	retroachievements? ( net-misc/curl[curl_ssl_gnutls] )
	X? (
			x11-libs/libX11
			x11-libs/libXrandr
	)
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/duckstation-${VERSION_COMMIT}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_NOGUI_FRONTEND=$(usex nogui)
		-DBUILD_QT_FRONTEND=$(usex qt5)
		-DENABLE_CHEEVOS=$(usex retroachievements)
		–DENABLE_DISCORD_PRESENCE=$(usex discord)
		-DUSE_DRMKMS=$(usex gbm)
		-DUSE_EGL=$(usex egl)
		-DUSE_EVDEV=$(usex evdev)
		-DUSE_FBDEV=$(usex fbdev)
		-DUSE_SDL2=$(usex gamepad)
		-DUSE_WAYLAND=$(usex wayland)
		-DUSE_X11=$(usex X)
		-DBUILD_SHARED_LIBS=OFF
	)
	cmake_src_configure
}

src_install() {
	dodoc README.md

	# Binary and resources files must be in same directory – installing in /opt
	insinto /opt/${PN}
	doins -r "${BUILD_DIR}"/bin/{database,inputprofiles,resources,shaders,translations}

	if use nogui; then
		for i in {16,32,48,64,128,256}; do
			newicon -s ${i} extras/icons/icon-${i}px.png duckstation-nogui.png
		done
		domenu extras/linux-desktop-files/duckstation-nogui.desktop

		doins "${BUILD_DIR}"/bin/duckstation-nogui
		dosym ../../opt/${PN}/duckstation-nogui usr/bin/duckstation-nogui
		fperms +x /opt/${PN}/duckstation-nogui
	fi

	if use qt5; then
		for i in {16,32,48,64,128,256}; do
			newicon -s ${i} extras/icons/icon-${i}px.png duckstation-qt.png
		done
		domenu extras/linux-desktop-files/duckstation-qt.desktop

		doins "${BUILD_DIR}"/bin/duckstation-qt
		dosym ../../opt/${PN}/duckstation-qt usr/bin/duckstation-qt
		fperms +x /opt/${PN}/duckstation-qt
	fi
}
