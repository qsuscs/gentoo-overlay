# Copyright 2020 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit autotools

DESCRIPTION="Extract page mode and named destinations as PDFmark from PDF"
HOMEPAGE="https://github.com/trueroad/extractpdfmark"
SRC_URI="https://github.com/trueroad/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-3+"

SLOT="0"

KEYWORDS="~amd64"

IUSE="test"
RESTRICT="!test? ( test )"
RDEPEND="
	>=app-text/poppler-0.74[cxx]
"
DEPEND="
	${RDEPEND}
	test? ( >=app-text/ghostscript-gpl-9.14 )
"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/Fix-memory-leak.patch"
)

src_prepare() {
	default
	config_rpath_update
	eautoreconf
}

src_configure() {
	econf --with-poppler=cpp
}
