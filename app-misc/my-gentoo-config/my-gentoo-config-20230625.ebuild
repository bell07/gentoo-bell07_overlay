EAPI="7"
KEYWORDS="amd64 arm64"
SLOT="0"

IUSE="+portage"
HOMEPAGE="https://gitlab.com/bell07/my-gentoo-config"

DESCRIPTION="My configuration files with preferred settings"

COMMIT="ceb175d06d73494a6388c879f34455b711868f12"

SRC_URI="${HOMEPAGE}/-/archive/${COMMIT}/my-gentoo-config-${COMMIT}.zip -> ${P}.zip"
RESTRICT="mirror"
S="${WORKDIR}/my-gentoo-config-${COMMIT}"

src_install() {
	if use portage; then
		insinto /etc
		doins -r portage
	fi
}
