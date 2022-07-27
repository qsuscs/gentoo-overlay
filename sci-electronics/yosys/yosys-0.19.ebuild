# Copyright 2022 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit python-any-r1 toolchain-funcs

DESCRIPTION="Framework for Verilog RTL synthesis"
HOMEPAGE="https://yosyshq.net/yosys/"

SRC_URI="https://github.com/YosysHQ/yosys/archive/refs/tags/${P}.tar.gz"
S="${WORKDIR}/${PN}-${P}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"

IUSE="tcl libffi readline libedit zlib test"
REQUIRED_USE="?? ( readline libedit )"
RESTRICT="!test? ( test )"

CDEPEND="
	tcl? ( dev-lang/tcl:= )
	libffi? ( dev-libs/libffi:= )
	readline? ( sys-libs/readline:= )
	libedit? ( dev-libs/libedit:= )
	zlib? ( sys-libs/zlib:= )
"

RDEPEND="
	sci-electronics/abc
"

DEPEND="
	${CDEPEND}
"

BDEPEND="
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
	${PYTHON_DEPS}
	test? (
		sci-electronics/abc
		sci-electronics/iverilog
	)
"

src_configure() {
	tc-export CC CXX PKG_CONFIG
	cat <<EOF > Makefile.conf
CONFIG := none
PRETTY := 0
ENABLE_TCL := $(usex tcl 1 0)
ENABLE_ABC := 1
ABCEXTERNAL = abc
ENABLE_PLUGINS := $(usex libffi 1 0)
ENABLE_READLINE := $(usex readline 1 0)
ENABLE_EDITLINE := $(usex libedit 1 0)
ENABLE_ZLIB := $(usex zlib 1 0)
override PYTHON_EXECUTABLE := ${EPYTHON}
STRIP := :
PREFIX := ${EPREFIX}/usr
LD := ${CXX}
EOF
}
