# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# TODO: multiple ABI?
LUA_COMPAT=( lua5-{1..4} )
PYTHON_COMPAT=( python3_{9..12} )
inherit flag-o-matic cmake lua-single python-single-r1 git-r3

DESCRIPTION="Crazy Eddie's GUI System"
HOMEPAGE="http://www.cegui.org.uk/"

EGIT_REPO_URI="https://github.com/cegui/cegui"
EGIT_BRANCH="master"

LICENSE="MIT"
SLOT="0"

IUSE="bidi debug devil doc freeimage gtk2 +expat irrlicht lua ogre opengl pcre python sdl static-libs tinyxml truetype xerces-c xml zip"
#( expat tinyxml xerces-c xml )
REQUIRED_USE="|| ( expat tinyxml xerces-c )
	lua? ( ${LUA_REQUIRED_USE} )
	python? ( ${PYTHON_REQUIRED_USE} )"

# gles broken
#	gles? ( media-libs/mesa[gles1] ) #or media-libs/libglvnd?
# directfb broken
#	directfb? ( dev-libs/DirectFB )
RDEPEND="
	dev-libs/boost:=
	virtual/libiconv
	gtk2? ( x11-libs/gtk+:2 )
	bidi? ( dev-libs/fribidi )
	devil? ( media-libs/devil )
	expat? ( dev-libs/expat )
	freeimage? ( media-libs/freeimage )
	irrlicht? ( dev-games/irrlicht )
	lua? (
		${LUA_DEPS}
		dev-lua/toluapp[${LUA_SINGLE_USEDEP}]
	)
	ogre? ( >=dev-games/ogre-1.7:= )
	opengl? (
		virtual/opengl
		virtual/glu
		media-libs/glew:=
	)
	pcre? ( dev-libs/libpcre )
	python? (
		${PYTHON_DEPS}
		$(python_gen_cond_dep '
			dev-libs/boost:=[python,${PYTHON_USEDEP}]
		')
	)
	sdl? ( media-libs/sdl2-image )
	tinyxml? ( dev-libs/tinyxml )
	truetype? ( media-libs/freetype:2 )
	xerces-c? ( dev-libs/xerces-c )
	xml? ( dev-libs/libxml2:2 )
	zip? ( sys-libs/zlib[minizip] )"

DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	opengl? ( media-libs/glm )"

BDEPEND="
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

pkg_setup() {
	use lua && lua-single_pkg_setup
	use python && python-single-r1_pkg_setup
}

src_configure() {
	# http://www.cegui.org.uk/mantis/view.php?id=991
	append-ldflags $(no-as-needed)

	local mycmakeargs=(
		-DCEGUI_BUILD_APPLICATION_TEMPLATES=OFF
		-DCEGUI_BUILD_IMAGECODEC_CORONA=OFF
		-DCEGUI_BUILD_IMAGECODEC_DEVIL=$(usex devil)
		-DCEGUI_BUILD_IMAGECODEC_FREEIMAGE=$(usex freeimage)
		-DCEGUI_BUILD_IMAGECODEC_PVR=OFF
		-DCEGUI_BUILD_IMAGECODEC_SDL2=$(usex sdl)
		-DCEGUI_BUILD_IMAGECODEC_SILLY=OFF
		-DCEGUI_BUILD_IMAGECODEC_STB=ON
		-DCEGUI_BUILD_IMAGECODEC_TGA=OFF
		-DCEGUI_BUILD_LUA_GENERATOR=$(usex lua)
		-DCEGUI_BUILD_LUA_MODULE=$(usex lua)
		-DCEGUI_BUILD_PYTHON_MODULES_PYPLUSPLUS=$(usex python)
		-DCEGUI_BUILD_PYTHON_MODULES_SWIG=OFF
		-DCEGUI_BUILD_RENDERER_DIRECT3D11=OFF
		-DCEGUI_BUILD_RENDERER_DIRECTFB=OFF
		-DCEGUI_BUILD_RENDERER_IRRLICHT=$(usex irrlicht)
		-DCEGUI_BUILD_RENDERER_NULL=ON
		-DCEGUI_BUILD_RENDERER_OGRE=$(usex ogre)
		-DCEGUI_BUILD_RENDERER_OPENGL=$(usex opengl)
		-DCEGUI_BUILD_RENDERER_OPENGL3=$(usex opengl)
		-DCEGUI_BUILD_RENDERER_OPENGLES=OFF
		-DCEGUI_BUILD_RENDERER_OPENGLES2_ALTERNATE=OFF
		-DCEGUI_BUILD_RENDERER_OPENGLES2_ALTERNATE_WITH_GLES3_SUPPORT=OFF
		-DCEGUI_BUILD_RESOURCE_PROVIDER_MINIZIP=$(usex zip)
		-DCEGUI_BUILD_SAMPLES=OFF
		-DCEGUI_BUILD_STATIC_CONFIGURATION=$(usex static-libs)
		-DCEGUI_BUILD_TESTS=OFF
		-DCEGUI_BUILD_XMLPARSER_EXPAT=$(usex expat)
		-DCEGUI_BUILD_XMLPARSER_LIBXML2=$(usex xml)
		-DCEGUI_BUILD_XMLPARSER_PUGIXML=OFF
		-DCEGUI_BUILD_XMLPARSER_TINYXML2=$(usex tinyxml)
		-DCEGUI_BUILD_XMLPARSER_XERCES=$(usex xerces-c)
		-DCEGUI_USE_FREETYPE=$(usex truetype)
		-DCEGUI_USE_FRIBIDI=$(usex bidi)
		-DCEGUI_USE_GLEW=$(usex opengl)
		-DCEGUI_USE_MINIBIDI=OFF
		-DCEGUI_USE_RAQM=OFF
		-DOpenGL_GL_PREFERENCE="GLVND"
	)

	cmake_src_configure
}

src_compile() {
	cmake_src_compile all $(usex doc html "")
}

src_install() {
	cmake_src_install
	docinto html
	use doc && dodoc -r "${BUILD_DIR}"/doc/doxygen/html/*
}
