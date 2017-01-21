# Copyright 1999-2017 Gentoo Foundation
# Copyright 2017 Thomas Schneider <qsx@qsx.re>
# Distributed under the terms of the ISC License

EAPI=6

HASH="2f0fe1a5d78f5cd340baf299a2345a895c307c2e"
DESCRIPTION="OpenSSL bindings for ObjFW."
HOMEPAGE="https://heap.zone/git?p=objopenssl.git"
SRC_URI="https://github.com/Midar/${PN}/archive/${HASH}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2 GPL-3 QPL"
S="${WORKDIR}/${PN}-${HASH}"

inherit autotools

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="|| ( sys-devel/clang sys-devel/gcc:*[objc] )
	dev-libs/objfw"

RDEPEND="${DEPEND}"

src_prepare () {
	default
	eautoreconf
}
