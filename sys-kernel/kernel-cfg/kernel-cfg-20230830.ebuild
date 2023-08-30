EAPI=7
KEYWORDS="amd64"
SLOT="0"

HOMEPAGE="https://github.com/bell07/bashscripts-kernel_cfg"
DESCRIPTION='Kernel configuration snippets (eselect version)'

COMMIT="36ad31b6b86ba25c2ff77771a793cdc8a84e3b7a"

SRC_URI="${HOMEPAGE}/archive/${COMMIT}.zip -> ${P}.zip"

RESTRICT="mirror"

S="${WORKDIR}/bashscripts-kernel_cfg-${COMMIT}"

src_install() {
	insinto /etc/kernel/config.avail
	for i in "${S}"/cfg/*; do
		doins "$i"
	done

	insinto /usr/share/kernel_cfg
	doins -r "${S}"/distro

	dosbin "${S}"/kernel_cfg.sh
	dosbin "${S}"/kernel_build.sh

	insinto /usr/share/eselect/modules
	doins "${S}"/kernel-cfg.eselect

	insinto /etc
	newins settings.env.example kernel-cfg.env

	dodoc "${S}"/README.md
}
