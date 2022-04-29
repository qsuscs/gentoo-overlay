# Copyright 2022 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit toolchain-funcs

DESCRIPTION="wayland event viewer"
HOMEPAGE="https://git.sr.ht/~sircmpwn/wev"

SRC_URI="https://git.sr.ht/~sircmpwn/wev/archive/${PV}.tar.gz -> ${P}.tar.gz"
PATCHES=(
	"${FILESDIR}/0be512fb705831b55020e1eaf86eedba0eae4a75.patch"
	"${FILESDIR}/54de46d120396ead4dcbce0b52cf506c200380f5.patch"
)

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
	app-text/scdoc
	dev-util/wayland-scanner
	virtual/pkgconfig
"

src_prepare() {
	default
	sed -i '/-std=/s/-g //' Makefile || die "sed failed"
}

src_configure() {
	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	einstalldocs
}
