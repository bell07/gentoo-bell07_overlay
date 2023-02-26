EAPI=7
KEYWORDS="amd64"
SLOT="0"

HOMEPAGE="https://github.com/bell07/bashscripts-kernel_cfg"
DESCRIPTION='Kernel configuration snippets (eselect version)'

COMMIT="64f153f0845c3acf9a359fc585faac863a34a9c4"
SRC_URI="https://github.com/bell07/bashscripts-kernel_cfg/archive/${COMMIT}.zip -> kernel-cfg-${PV}.zip"

S="${WORKDIR}/bashscripts-kernel_cfg-${COMMIT}"

src_install() {
	insinto /etc/kernel/config.avail
	for i in "${S}"/cfg/*; do
		doins "$i"
	done

	insinto /usr/share/eselect/modules
	doins "${S}"/kernel-cfg.eselect

	dodoc "${S}"/README.md
}
