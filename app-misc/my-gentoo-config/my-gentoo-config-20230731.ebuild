EAPI="7"
KEYWORDS="amd64 arm64"
SLOT="0"

IUSE="gaming +portage"
HOMEPAGE="https://gitlab.com/bell07/my-gentoo-config"

DESCRIPTION="My configuration files with preferred settings"

COMMIT="e1b5edfff38e23d36edd433aabed84e044c16343"

SRC_URI="${HOMEPAGE}/-/archive/${COMMIT}/my-gentoo-config-${COMMIT}.zip -> ${P}.zip"
RESTRICT="mirror"
S="${WORKDIR}/my-gentoo-config-${COMMIT}"

src_install() {
	insinto /etc
	if use gaming; then
		doins -r security
		doins -r sysctl.d
	fi

	if use portage; then
		doins -r portage
	fi
}
