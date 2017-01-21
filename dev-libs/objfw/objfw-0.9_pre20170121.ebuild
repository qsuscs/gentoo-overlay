# Copyright 1999-2017 Gentoo Foundation
# Copyright 2017 Thomas Schneider <qsx@qsx.re>
# Distributed under the terms of the ISC License

EAPI=6

HASH="dfa15c379dbb27013343c6995d850a50ef36297b"
DESCRIPTION="A portable Objective-C framework."
HOMEPAGE="https://heap.zone/objfw/"
SRC_URI="https://github.com/Midar/objfw/archive/${HASH}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2 GPL-3 QPL"
S="${WORKDIR}/${PN}-${HASH}"

inherit autotools

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="|| ( sys-devel/clang sys-devel/gcc:*[objc] )"

RDEPEND="${DEPEND}"

src_prepare () {
	default
	eautoreconf
}
