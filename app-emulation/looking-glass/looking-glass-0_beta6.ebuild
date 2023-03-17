# Copyright 2023 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL
EAPI=8

inherit cmake

MY_PV="${PV/0_beta/B}"

DESCRIPTION="A low latency KVM FrameRelay implementation for guests with VGA PCI Passthrough"
HOMEPAGE="https://looking-glass.io/"
SRC_URI="https://looking-glass.io/artifact/${MY_PV}/source -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${MY_PV}"
CMAKE_USE_DIR="${S}/client"

# looking-glass, LGMP, PureSpice: GPL-2
# cimgui, wayland-protocols: MIT
# nanosvg: ZLIB
LICENSE="GPL-2 MIT ZLIB"

SLOT="0"

KEYWORDS="~amd64"

IUSE="X debug doc pipewire pulseaudio wayland"
REQUIRED_USE="|| ( X wayland )"

RDEPEND="
	media-libs/libglvnd[X?]
	x11-libs/libxkbcommon[X?,wayland?]
	media-libs/fontconfig
	dev-libs/nettle:=[gmp]

	X? (
		x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXfixes
		x11-libs/libXScrnSaver
		x11-libs/libXinerama
		x11-libs/libXcursor
		x11-libs/libXpresent
	)
	debug? (
		sys-libs/binutils-libs:=
	)
	pipewire? (
		media-video/pipewire:=
		media-libs/libsamplerate
	)
	pulseaudio? (
		media-libs/libpulse
		media-libs/libsamplerate
	)
	wayland? (
		dev-libs/wayland
	)
"
DEPEND="
	${RDEPEND}
	app-emulation/spice-protocol
"
BDEPEND="
	wayland? (
		dev-util/wayland-scanner
	)
	doc? (
		dev-python/sphinx
		dev-python/sphinx-rtd-theme
	)
"

src_prepare() {
	cmake_src_prepare

	find -name CMakeLists.txt -execdir \
		sed -i "/-Werror/d" '{}' + \
		|| die "sed failed"
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_BACKTRACE=$(usex debug)
		-DENABLE_PIPEWIRE=$(usex pipewire)
		-DENABLE_PULSEAUDIO=$(usex pulseaudio)
		-DENABLE_WAYLAND=$(usex wayland)
		-DENABLE_X11=$(usex X)
		-DOPTIMIZE_FOR_NATIVE_ARCH=none
	)
	cmake_src_configure
}

src_compile() {
	cmake_src_compile

	use doc && emake -C doc html
}

src_install() {
	cmake_src_install

	DOCS=( AUTHORS CONTRIBUTORS README.md client/DEBUGGING.md )
	use doc && HTML_DOCS=( doc/_build/html/. )
	einstalldocs
}
