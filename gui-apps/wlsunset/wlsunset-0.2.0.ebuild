# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit meson

DESCRIPTION="Day/night gamma adjustments for Wayland"

HOMEPAGE="https://git.sr.ht/~kennylevinsen/wlsunset"
SRC_URI="https://git.sr.ht/~kennylevinsen/wlsunset/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
	dev-libs/wayland
"
DEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
"
BDEPEND="
	app-text/scdoc
	dev-util/wayland-scanner
"

src_prepare() {
	default
	sed -i '/werror/d' meson.build || die
}
