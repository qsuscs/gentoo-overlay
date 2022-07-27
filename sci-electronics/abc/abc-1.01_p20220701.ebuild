# Copyright 2022 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit toolchain-funcs

DESCRIPTION="ABC: System for Sequential Logic Synthesis and Formal Verification"
HOMEPAGE="https://github.com/YosysHQ/abc"

COMMIT_HASH="18634305282c81b0f4a08de4ebca6ccc95b11748"
SRC_URI="https://github.com/YosysHQ/abc/archive/${COMMIT_HASH}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT_HASH}"

LICENSE="Old-MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	app-arch/bzip2:=
	sys-libs/readline:=
	sys-libs/zlib:=
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/unbundle-zlib-bzlib.patch"
)

src_prepare() {
	default
	rm -rf src/misc/{bzlib,zlib}
}

src_compile() {
	emake CC=$(tc-getCC) CXX=$(tc-getCXX) AR=$(tc-getAR) \
		  OPTFLAGS= ABC_USE_STDINT_H=1 ABC_MAKE_VERBOSE=1 \
		  abc
}

src_install() {
	dobin abc
	dodoc README.md readmeaig abc.rc
}
