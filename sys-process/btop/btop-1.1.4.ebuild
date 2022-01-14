# Copyright 2022 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A monitor of resources"
HOMEPAGE="https://foo.example.org/"
SRC_URI="https://github.com/aristocratos/btop/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0 MIT"
SLOT="0"

KEYWORDS="~amd64"
IUSE=""

src_prepare() {
	default
	sed -i '/^\t@sleep/d' Makefile
}

src_compile() {
	emake CXX="$(tc-getCXX)" OPTFLAGS="${CXXFLAGS}" ADDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
	DOCS=( *.md )
	einstalldocs
	rm -f "${D}/${EPREFIX}/usr/share/btop/README.md"
}
