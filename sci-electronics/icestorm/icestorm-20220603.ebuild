# Copyright 2022 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit python-single-r1 toolchain-funcs

DESCRIPTION="Lattice iCE40 FPGAs Bitstream Documentaion (Reverse Engineered)"
HOMEPAGE="http://bygone.clairexen.net/icestorm/"

COMMIT_HASH="2bc541743ada3542c6da36a50e66303b9cbd2059"
SRC_URI="https://github.com/YosysHQ/icestorm/archive/${COMMIT_HASH}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT_HASH}"

LICENSE="ISC"

SLOT="0"
KEYWORDS="~amd64"

IUSE="iceprog"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

CDEPEND="
	iceprog? ( dev-embedded/libftdi:= )
"
DEPEND="
	${CDEPEND}
"
RDEPEND="
	${CDEPEND}
	${PYTHON_DEPS}
"
BDEPEND="
	iceprog? ( virtual/pkg-config )
	${PYTHON_DEPS}
"

src_prepare() {
	default
	sed -i 's/^install/noinstall/' icebox/Makefile || die
	echo 'install: ;' >> icebox/Makefile || die
}

src_configure() {
	tc-export CXX CC PKG_CONFIG
	cat <<EOF > config.mk
PREFIX = ${EPREFIX}/usr
ICEPROG = $(usex iceprog 1 0)
PROGRAM_PREFIX =
LDLIBS = -lm
CFLAGS += -MD -MP -Wall -std=c99
CXXFLAGS += -MD -MP -std=c++11
CHIPDB_SUBDIR = \$(PROGRAM_PREFIX)icebox
PYTHON3 = ${EPYTHON}
EOF
}

src_install() {
	emake DESTDIR="${D}" install

	pushd icebox
	python_domodule icebox.py iceboxdb.py
	local i
	for i in icebox_*.py; do
		python_newscript "${i}" "${i%.py}"
	done
	popd

	DOCS=( README examples )
	HTML_DOCS=( docs/. )
	einstalldocs
}

src_test() {
	emake -C icebox check
	## Requires proprietary tool
	# emake -C icetime test
	## Requires arachne-pnr, not packaged
	# emake -C icebram test
}
