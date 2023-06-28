EAPI="7"
KEYWORDS="amd64 arm64"
SLOT="0"

IUSE="+limits +portage"
HOMEPAGE="https://gitlab.com/bell07/my-gentoo-config"

DESCRIPTION="My configuration files with preferred settings"

COMMIT="7d14290ae046e63cd7db29b187b905ab44937f6f"

SRC_URI="${HOMEPAGE}/-/archive/${COMMIT}/my-gentoo-config-${COMMIT}.zip -> ${P}.zip"
RESTRICT="mirror"
S="${WORKDIR}/my-gentoo-config-${COMMIT}"

src_install() {
	insinto /etc

	if use limits; then
		doins -r security
	fi

	if use portage; then
		doins -r portage
	fi
}
