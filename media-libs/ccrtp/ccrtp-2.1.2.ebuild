# Copyright 2020 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

DESCRIPTION="GNU ccRTP is an implementation of RTP"
HOMEPAGE="https://www.gnu.org/software/ccrtp/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="doc static-libs"

RDEPEND="
	dev-libs/libgcrypt:=[static-libs?]
	dev-libs/ucommon:=[static-libs?]
"

DEPEND="${RDEPEND}"

BDEPEND="
	doc? ( app-doc/doxygen )
"

src_configure() {
	use doc || export DOXYGEN=/bin/true
	econf $(use_enable static-libs static)
}

src_install() {
	use doc && HTML_DOCS=( doc/html )
	default
	use static-libs || { find "${D}" -name '*.la' -delete || die; }
}
