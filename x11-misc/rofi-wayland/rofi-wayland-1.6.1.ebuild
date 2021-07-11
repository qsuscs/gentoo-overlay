# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

MY_PV="${PV}-wayland"
MY_PN="rofi"
MY_P="${MY_PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

LIBGWATER_VERSION="e6faf48267ae40547cb86c125f265f54f382df1c"
LIBNKUTILS_VERSION="6164bacaef10031ce77380499cfad2ae818ab6b0"

DESCRIPTION="A window switcher, run dialog and dmenu replacement -- wayland fork"
HOMEPAGE="https://github.com/lbonn/rofi"
SRC_URI="
	https://github.com/lbonn/rofi/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/sardemff7/libgwater/archive/${LIBGWATER_VERSION}.tar.gz -> libgwater-${LIBGWATER_VERSION}.tar.gz
	https://github.com/sardemff7/libnkutils/archive/${LIBNKUTILS_VERSION}.tar.gz -> libnkutils-${LIBNKUTILS_VERSION}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="+drun test +windowmode +wayland"
RESTRICT="!test? ( test )"

BDEPEND="
	virtual/pkgconfig
	wayland? ( dev-util/wayland-scanner )
"
RDEPEND="
	dev-libs/glib:2
	gnome-base/librsvg:2
	media-libs/freetype
	virtual/jpeg
	x11-libs/cairo[X,xcb(+)]
	x11-libs/libXft
	x11-libs/libXinerama
	x11-libs/libxcb
	x11-libs/libxkbcommon[X]
	x11-libs/pango[X]
	x11-libs/startup-notification
	x11-libs/xcb-util
	x11-libs/xcb-util-wm
	x11-libs/xcb-util-xrm
	wayland? ( dev-libs/wayland )
	!!x11-misc/rofi
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
	test? ( >=dev-libs/check-0.11 )
	wayland? ( dev-libs/wayland-protocols )
"

src_unpack() {
	default

	rmdir "${S}"/subprojects/lib{gwater,nkutils} || die

	mv "${WORKDIR}"/libgwater-${LIBGWATER_VERSION} "${S}"/subprojects/libgwater || die
	mv "${WORKDIR}"/libnkutils-${LIBNKUTILS_VERSION} "${S}"/subprojects/libnkutils || die
}

src_configure() {
	local emesonargs=(
		$(meson_use drun)
		$(meson_use windowmode window)
		$(meson_feature test check)
		$(meson_feature wayland)
	)
	meson_src_configure
}
