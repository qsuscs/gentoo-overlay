# Copyright 2022 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit meson

DESCRIPTION="xdotool type for wayland"
HOMEPAGE="https://github.com/atx/wtype"

SRC_URI="https://github.com/atx/wtype/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
	dev-libs/wayland
	x11-libs/libxkbcommon[wayland]
"
DEPEND="
	dev-libs/wayland-protocols
	${RDEPEND}
"

BDEPEND="
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	default
	sed -i -e 's/not git\.found()/true/' meson.build || die "sed failed"
}
