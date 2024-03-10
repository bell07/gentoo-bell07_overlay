# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-mod-r1

DESCRIPTION="Valve Steam Deck firmware tools (Flash does not work yet)"
HOMEPAGE="https://gitlab.com/evlaV/jupiter-hw-support/"
SLOT="0"

EGIT_REPO_URI="https://gitlab.com/evlaV/jupiter-hw-support/"
EGIT_BRANCH="master"

# dev-python/hid is in salfter overlay
RDEPEND="
app-misc/jq
dev-python/click
dev-python/crcmod
dev-python/hid
dev-python/progressbar2
net-libs/libsoup:2.4
"
DEPEND="$RDEPEND"

MODULES_KERNEL_MAX="6.1"

PATCHES=(
"${FILESDIR}"/kernel-version.patch
"${FILESDIR}"/remove-outdated-makro.patch
)


modlist=( phy_alloc )

src_compile() {
	cd usr/share/jupiter_bios_updater/driver/
	export CROSS_COMPILE=""
	linux-mod-r1_src_compile
}

src_install() {
	dobin usr/bin/jupiter-biosupdate
	dobin usr/bin/jupiter-controller-update

	insinto usr/share
	doins -r usr/share/jupiter_bios

	exeinto usr/share/jupiter_bios_updater
	doexe usr/share/jupiter_bios_updater/{BatCtrl,h2offt,h2offt-g,H2OFFTx64-G.sh,H2OFFTx64.sh,h2osde-lx64}
	insinto usr/share/jupiter_bios_updater
	doins usr/share/jupiter_bios_updater/{msg_cht.ini,msg_eng.ini,platform.ini}

	exeinto usr/share/jupiter_controller_fw_updater
	doexe usr/share/jupiter_controller_fw_updater/{d20bootloader.py,d21bootloader16.py}
	insinto usr/share/jupiter_controller_fw_updater
	doins usr/share/jupiter_controller_fw_updater/*.bin

	exeinto usr/share/jupiter_controller_fw_updater/RA_bootloader_updater
	doexe usr/share/jupiter_controller_fw_updater/RA_bootloader_updater/rfp_cli_linux.sh
	insinto usr/share/jupiter_controller_fw_updater/RA_bootloader_updater
	doins usr/share/jupiter_controller_fw_updater/RA_bootloader_updater/boot_ra_Release.srec

	exeinto usr/share/jupiter_controller_fw_updater/RA_bootloader_updater/linux_host_tools
	doexe usr/share/jupiter_controller_fw_updater/RA_bootloader_updater/linux_host_tools/BatCtrl
	insinto usr/share/jupiter_controller_fw_updater/RA_bootloader_updater/linux_host_tools
	doins -r usr/share/jupiter_controller_fw_updater/RA_bootloader_updater/linux_host_tools/rfp-linux-x64

	linux-mod-r1_src_install
}
