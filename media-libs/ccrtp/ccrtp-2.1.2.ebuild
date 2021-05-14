# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit flag-o-matic

DESCRIPTION="GNU ccRTP is an implementation of RTP"
HOMEPAGE="https://www.gnu.org/software/ccrtp/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc"

RDEPEND="
	dev-libs/libgcrypt:=
	dev-libs/ucommon:=
"

DEPEND="${RDEPEND}"

BDEPEND="
	doc? ( app-doc/doxygen )
"

src_configure() {
	use doc || export DOXYGEN=/bin/true
	append-cxxflags "-std=c++11"
	econf --disable-static
}

src_install() {
	use doc && HTML_DOCS=( doc/html )
	default
	find "${D}" -name '*.la' -delete || die
}
