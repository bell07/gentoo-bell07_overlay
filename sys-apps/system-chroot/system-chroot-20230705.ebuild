EAPI=7
KEYWORDS="amd64 arm64"
SLOT="0"

HOMEPAGE="https://github.com/bell07/bashscripts-system_chroot"
DESCRIPTION='Prepare a system root to be mounted in chroot. Do all submounts like sys or proc.'

COMMIT="9fe2372e9a495d0caa535d2de1c30f89e5e4924d"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.zip -> ${P}.zip"

RESTRICT="mirror"

S="${WORKDIR}/bashscripts-system_chroot-${COMMIT}"

src_install() {
	dobin "${S}"/chroot-mount.sh
	dobin "${S}"/chroot-umount.sh
	dodoc "${S}"/README.md
}
