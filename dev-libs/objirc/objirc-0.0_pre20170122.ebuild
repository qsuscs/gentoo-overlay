# Copyright 1999-2017 Gentoo Foundation
# Copyright 2017 Thomas Schneider <qsx@qsx.re>
# Distributed under the terms of the ISC License

EAPI=6

HASH="df4414d10b1858cdeaa907108c923ed82dd7849e"
DESCRIPTION="An IRC library for ObjFW."
HOMEPAGE="https://heap.zone/git/?p=objirc.git"
SRC_URI="https://github.com/Midar/${PN}/archive/${HASH}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2 GPL-3 QPL"
S="${WORKDIR}/${PN}-${HASH}"

inherit autotools

SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE="doc"

RESTRICT="test"

RDEPEND="
	|| ( sys-devel/clang sys-devel/gcc:*[objc] )
	dev-libs/objfw"
DEPEND="${RDEPEND}"

src_prepare() {
	default
	eautoreconf
}
