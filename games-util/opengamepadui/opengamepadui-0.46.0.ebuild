# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI="8"

CRATES="
	ahash@0.7.8
	aho-corasick@1.1.4
	anyhow@1.0.102
	arrayvec@0.7.6
	async-broadcast@0.7.2
	async-channel@2.5.0
	async-executor@1.14.0
	async-io@2.6.0
	async-lock@3.4.2
	async-process@2.5.0
	async-recursion@1.1.1
	async-signal@0.2.13
	async-task@4.7.1
	async-trait@0.1.89
	atomic-waker@1.1.2
	autocfg@1.5.0
	bitflags@2.11.0
	bitvec@1.0.1
	blocking@1.6.2
	borsh-derive@1.6.1
	borsh@1.6.1
	bumpalo@3.20.2
	byte-unit@5.2.0
	bytecheck@0.6.12
	bytecheck_derive@0.6.12
	bytes@1.11.1
	cfg-if@1.0.4
	cfg_aliases@0.2.1
	concurrent-queue@2.5.0
	crossbeam-utils@0.8.21
	dyn-clone@1.0.20
	endi@1.1.1
	enumflags2@0.7.12
	enumflags2_derive@0.7.12
	equivalent@1.0.2
	errno@0.3.14
	event-listener-strategy@0.5.4
	event-listener@5.4.1
	fastrand@2.3.0
	foldhash@0.1.5
	funty@2.0.0
	futures-core@0.3.32
	futures-io@0.3.32
	futures-lite@2.6.1
	futures-macro@0.3.32
	futures-task@0.3.32
	futures-util@0.3.32
	gdextension-api@0.3.3
	gethostname@1.1.0
	getrandom@0.2.17
	getrandom@0.4.2
	glam@0.30.10
	godot-bindings@0.4.5
	godot-cell@0.4.5
	godot-codegen@0.4.5
	godot-core@0.4.5
	godot-ffi@0.4.5
	godot-macros@0.4.5
	godot@0.4.5
	hashbrown@0.12.3
	hashbrown@0.15.5
	hashbrown@0.16.1
	heck@0.4.1
	heck@0.5.0
	hermit-abi@0.5.2
	hex@0.4.3
	id-arena@2.3.0
	indexmap@2.13.0
	inotify-sys@0.1.5
	inotify@0.11.1
	itoa@1.0.18
	js-sys@0.3.91
	keyvalues-parser@0.2.3
	leb128fmt@0.1.0
	libc@0.2.183
	linux-raw-sys@0.12.1
	litrs@1.0.0
	lock_api@0.4.14
	log@0.4.29
	markdown@1.0.0-alpha.23
	memchr@2.8.0
	memoffset@0.9.1
	mio@1.1.1
	nanoserde-derive@0.2.1
	nanoserde@0.2.1
	nix@0.29.0
	nix@0.31.2
	num-traits@0.2.19
	once_cell@1.21.4
	ordered-stream@0.2.0
	parking@2.2.1
	parking_lot@0.12.5
	parking_lot_core@0.9.12
	pest@2.8.6
	pin-project-lite@0.2.17
	piper@0.2.5
	polling@3.11.0
	ppv-lite86@0.2.21
	prettyplease@0.2.37
	proc-macro-crate@3.5.0
	proc-macro2@1.0.106
	ptr_meta@0.1.4
	ptr_meta_derive@0.1.4
	quote@1.0.45
	r-efi@6.0.0
	radium@0.7.0
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.5.18
	ref-cast-impl@1.0.25
	ref-cast@1.0.25
	regex-automata@0.4.14
	regex-syntax@0.8.10
	regex@1.12.3
	rend@0.4.2
	rkyv@0.7.46
	rkyv_derive@0.7.46
	roxmltree@0.21.1
	rust_decimal@1.40.0
	rustix@1.1.4
	rustversion@1.0.22
	schemars@1.2.1
	scopeguard@1.2.0
	seahash@4.1.0
	semver@1.0.27
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.149
	serde_repr@0.1.20
	signal-hook-registry@1.4.8
	simdutf8@0.1.5
	slab@0.4.12
	smallvec@1.15.1
	socket2@0.6.3
	strum@0.25.0
	strum_macros@0.25.3
	syn@1.0.109
	syn@2.0.117
	tap@1.0.1
	tempfile@3.27.0
	tinyvec@1.11.0
	tinyvec_macros@0.1.1
	tokio-macros@2.6.1
	tokio@1.50.0
	toml_datetime@1.1.0+spec-1.1.0
	toml_edit@0.25.8+spec-1.1.0
	toml_parser@1.1.0+spec-1.1.0
	tracing-attributes@0.1.31
	tracing-core@0.1.36
	tracing@0.1.44
	ucd-trie@0.1.7
	uds_windows@1.2.1
	unicode-id@0.3.6
	unicode-ident@1.0.24
	unicode-xid@0.2.6
	utf8-width@0.1.8
	uuid@1.22.0
	venial@0.6.1
	version_check@0.9.5
	wasi@0.11.1+wasi-snapshot-preview1
	wasip2@1.0.2+wasi-0.2.9
	wasip3@0.4.0+wasi-0.3.0-rc-2026-01-06
	wasm-bindgen-macro-support@0.2.114
	wasm-bindgen-macro@0.2.114
	wasm-bindgen-shared@0.2.114
	wasm-bindgen@0.2.114
	wasm-encoder@0.244.0
	wasm-metadata@0.244.0
	wasmparser@0.244.0
	windows-link@0.2.1
	windows-sys@0.61.2
	winnow@0.7.15
	winnow@1.0.0
	wit-bindgen-core@0.51.0
	wit-bindgen-rust-macro@0.51.0
	wit-bindgen-rust@0.51.0
	wit-bindgen@0.51.0
	wit-component@0.244.0
	wit-parser@0.244.0
	wyz@0.5.1
	x11rb-protocol@0.13.2
	x11rb@0.13.2
	zbus@5.14.0
	zbus_macros@5.14.0
	zbus_names@4.3.1
	zerocopy-derive@0.8.47
	zerocopy@0.8.47
	zmij@1.0.21
	zvariant@5.10.0
	zvariant_derive@5.10.0
	zvariant_utils@3.3.0
"

declare -A GIT_CRATES=(
	[gamescope-x11-client]='https://github.com/ShadowBlip/gamescope-x11-client;922e02a8c941c278e665639c57a1822abd31bee3;gamescope-x11-client-%commit%'
)

inherit cargo udev xdg

DESCRIPTION="Game launcher and overlay designed with a gamepad native experience in mind."
HOMEPAGE="https://opengamepadui.readthedocs.io"

GODOT_VERSION="4.7.1"

SRC_URI="https://github.com/ShadowBlip/OpenGamepadUI/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-stable/Godot_v${GODOT_VERSION}-stable_export_templates.tpz
${CARGO_CRATE_URIS}
"
RESTRICT="mirror"

LICENSE="GPL-3"
KEYWORDS="~amd64"

TEMPLATES_ARCH="x86_64"

SLOT="0"

COMMON_DEPEND="
dev-build/scons
dev-libs/libevdev
dev-libs/libevdev
x11-libs/libX11
x11-libs/libXau
x11-libs/libxcb
x11-libs/libXcursor
x11-libs/libXdmcp
x11-libs/libXi
x11-libs/libXinerama
x11-libs/libXext
x11-libs/libXrandr
x11-libs/libXres
"

BDEPEND="app-arch/unzip"

DEPEND="${COMMON_DEPEND}
=dev-games/godot-${GODOT_VERSION}"

RDEPEND="${COMMON_DEPEND}
gui-wm/gamescope[libei]"

S="${WORKDIR}/OpenGamepadUI-${PV}"

PATCHES=("${FILESDIR}/0.46.0-preinstalled-templates.patch")

src_unpack() {
	cargo_src_unpack

	unzip "${DISTDIR}/Godot_v${GODOT_VERSION}-stable_export_templates.tpz" || die
	mkdir -pv "${HOME}/.local/share/godot/export_templates/${GODOT_VERSION}.stable" || die
	mv "templates/"* \
		"${HOME}/.local/share/godot/export_templates/${GODOT_VERSION}.stable" || die
}

src_prepare() {
	for i in {0..32}; do
		addpredict /dev/video${i}
		addpredict /dev/hidraw${i}
		addpredict /dev/input/event${i}
	done
	default
}

src_compile() {
	emake build
}

src_install() {
	export ARCH="${TEMPLATES_ARCH}"
	emake PREFIX="${D}/${EPREFIX}"/usr install
}
