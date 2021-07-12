# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit meson

DESCRIPTION="A Wayland kiosk"
HOMEPAGE="https://github.com/Hjdskes/cage"
SRC_URI="https://github.com/Hjdskes/cage/releases/download/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~x86"
IUSE="X"

BDEPEND="
	app-text/scdoc
	dev-util/wayland-scanner
	virtual/pkgconfig
"
RDEPEND="
	>=gui-libs/wlroots-0.14.0[X?]
	dev-libs/wayland
	x11-libs/libxkbcommon[wayland]
	x11-libs/pixman
"
DEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
"

src_configure() {
	local emesonargs=(
		$(meson_use X xwayland)
		-Dman-pages=enabled
	)
	meson_src_configure
}
