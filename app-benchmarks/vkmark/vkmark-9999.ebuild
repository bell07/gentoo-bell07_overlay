EAPI=8

inherit meson git-r3

DESCRIPTION="vkmark is an extensible Vulkan benchmarking suite with targeted, configurable scenes."
HOMEPAGE="https://github.com/vkmark/vkmark"

EGIT_REPO_URI="https://github.com/vkmark/${PN}"
EGIT_BRANCH="master"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm"
IUSE="drm wayland X"

COMMON_DEPEND="
	media-libs/glm
	media-libs/assimp
	X? (
		x11-libs/libxcb
	 )
	wayland? (
		dev-libs/wayland-protocols
	)
	drm? (
		x11-libs/libdrm
		media-libs/mesa[gbm(+)]
	)"

RDEPEND="
	${COMMON_DEPEND}
	media-libs/vulkan-loader

"
DEPEND="
	${COMMON_DEPEND}
	dev-util/vulkan-headers"

BDEPEND="
	dev-util/wayland-scanner
"

src_configure() {
	local emesonargs=(
		$(meson_use X xcb)
		$(meson_use drm kms)
		$(meson_use wayland wayland)
	)
	meson_src_configure
}
