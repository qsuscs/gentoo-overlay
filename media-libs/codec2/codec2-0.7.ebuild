# Copyright 1999-2017 Gentoo Foundation
# Copyright 2017 Thomas Schneider <qsx@qsx.re>
# Distributed under the terms of the ISC License

EAPI=6

inherit cmake-utils

DESCRIPTION="Codec 2 is an open source speech codec designed for low bandwidth"
HOMEPAGE="http://www.rowetel.com/?page_id=452"
SRC_URI="https://freedv.com/wp-content/uploads/sites/8/2017/10/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-util/cmake"
RDEPEND=""

PATCHES="${FILESDIR}/cmake.patch"
