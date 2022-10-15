# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod toolchain-funcs
BUILD_PARAMS="CC=$(tc-getCC) V=1 KSRC=${KERNEL_DIR}"

DESCRIPTION="Newest Realtek rtlwifi codes for RTL8822BE, RTL8822CE, RTL8821CE, and RTL8723DE"
HOMEPAGE="https://github.com/lwfinger/rtw88"

EGIT_REPO_URI="https://github.com/lwfinger/rtw88"
EGIT_REPO_BRANCH="master"

inherit git-r3
KEYWORDS="~amd64"

DEPEND="virtual/linux-sources"

MODULE_NAMES="
rtw_8821ce(net_wireless)
rtw_8821c(net_wireless)
rtw_8822be(net_wireless)
rtw_8822b(net_wireless)
rtw_8822ce(net_wireless)
rtw_8822c(net_wireless)
rtw_8723de(net-wireless)
rtw_8723d(net/wireless)
rtw_core(net_wireless)
rtw_pci(net_wireless)"

BUILD_TARGETS="all"
CONFIG_CHECK="~!RTW88"
