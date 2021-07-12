# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit autotools

DESCRIPTION="Dovecot FTS plugin based on Xapian"
HOMEPAGE="https://github.com/grosjo/fts-xapian"
SRC_URI="https://github.com/grosjo/fts-xapian/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/fts-xapian-${PV}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/icu:=
	>=dev-libs/xapian-1.4:=
	net-mail/dovecot
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--with-dovecot="${EPREFIX}/usr/$(get_libdir)/dovecot" \
		--disable-static
}

src_install() {
	default
	find "${D}" -name "*.la" -delete
}
