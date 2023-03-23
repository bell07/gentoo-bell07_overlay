# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod toolchain-funcs
BUILD_PARAMS="CC=$(tc-getCC) V=1 KSRC=${KERNEL_DIR}"

DESCRIPTION="Driver for USB WiFi Adapters that are based on the RTL8812BU and RTL8822BU Chipsets v5.13.1 (Realtek) (20210702) plus updates from the Linux community"
HOMEPAGE="https://github.com/morrownr/88x2bu-20210702"

EGIT_REPO_URI="https://github.com/morrownr/88x2bu-20210702"
EGIT_REPO_BRANCH="main"

inherit git-r3
KEYWORDS="~amd64"

DEPEND="virtual/linux-sources"

MODULE_NAMES="88x2bu(realtek)"

BUILD_TARGETS="all"
CONFIG_CHECK="~!RTW88"
