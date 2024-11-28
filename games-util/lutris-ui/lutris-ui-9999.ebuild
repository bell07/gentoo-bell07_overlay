# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit python-single-r1 xdg desktop git-r3

DESCRIPTION="Simple pygame based Lutris frontend"
HOMEPAGE="https://github.com/bell07/${PN}"

EGIT_REPO_URI="https://github.com/bell07/${PN}"
EGIT_BRANCH="main"

LICENSE="GPL-3+"
KEYWORDS="amd64"
SLOT="0"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		games-util/lutris[${PYTHON_SINGLE_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/pygame[${PYTHON_USEDEP}]
		dev-python/pyxdg[${PYTHON_USEDEP}]
		')"

src_install() {
	# Install python code
	insinto "/usr/share"
	cd "${S}"/src
	doins -r "${PN}"
	exeinto "/usr/share/${PN}"
	doexe "${PN}"/"${PN}".py
	python_optimize "${ED}/usr/share/${PN}"
	python_fix_shebang "${ED}/usr/share/${PN}"

	# Install resources
	cd "${S}"
	insinto "/usr/share/${PN}"
	doins -r resources
	dosym /usr/share/"${PN}"/resources/"${PN}".png /usr/share/pixmaps/"${PN}".png
	
	# Install config
	insinto "/etc/xdg/${PN}"	
	newins config.ini.example config.ini

	# Install documentation
	dodoc README.md
	dodoc LICENSE.txt

	# Install launch files
	dosym "/usr/share/${PN}/${PN}.py" /usr/bin/"${PN}"
	make_desktop_entry /usr/bin/"${PN}" "Lutris-UI"
}
