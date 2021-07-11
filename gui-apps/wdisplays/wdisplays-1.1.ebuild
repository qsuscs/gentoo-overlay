# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit meson

DESCRIPTION="GUI display configurator for wlroots compositors"

HOMEPAGE="https://github.com/artizirk/wdisplays"
SRC_URI="https://github.com/artizirk/wdisplays/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3+"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
	dev-libs/wayland
	media-libs/libepoxy
	x11-libs/gtk+:3[wayland]
"
DEPEND="
	${RDEPEND}
	dev-libs/wayland-protocols
"
BDEPEND="
	dev-libs/glib
	dev-util/wayland-scanner
	media-gfx/scour
"
