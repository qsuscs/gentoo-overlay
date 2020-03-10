# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit toolchain-funcs

MY_PV=2.3.i

DESCRIPTION="Customizable, extensible automatic printer filter"
HOMEPAGE="http://www.pell.portland.or.us/~orc/Code/magicfilter/"
SRC_URI="https://github.com/Orc/magicfilter/archive/v${MY_PV}.tar.gz -> ${PN}-${MY_PV}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="lprng-failsafe"

DEPEND="app-text/ghostscript-gpl"
RDEPEND="${DEPEND}
	lprng-failsafe? ( net-print/lprng )"

S=${WORKDIR}/${PN}-${MY_PV}

PATCHES=(
	"${FILESDIR}"/${PN}-2.3h-configure.patch
	"${FILESDIR}"/${PN}-2.3h-makefile.patch
)

src_configure() {
	local myconf
	use lprng-failsafe && myconf="--with-lprng"

	tc-export CC
	export AC_CPP_PROG="$(tc-getCPP)"

	./configure.sh \
		--prefix="${EPREFIX}"/usr \
		--mandir="${EPREFIX}"/usr/share/man \
		--filterdir="${EPREFIX}"/usr/share/magicfilter/filters \
		${myconf} || die
}
