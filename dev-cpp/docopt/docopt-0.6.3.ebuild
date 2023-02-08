# Copyright 2023 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )
inherit cmake python-any-r1

MY_PN="${PN}.cpp"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="C++11 port of docopt"
HOMEPAGE="https://github.com/docopt/docopt.cpp"
SRC_URI="https://github.com/docopt/docopt.cpp/archive/refs/tags/v${PV}.tar.gz -> ${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"
LICENSE="MIT Boost-1.0"
SLOT="0"

KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( ${PYTHON_DEPS} )"

PATCHES=(
	# from Debian
	"${FILESDIR}/Make-tests-compatible-with-Python-3.patch"
)

DOCS=( README.rst examples )

src_prepare() {
	cmake_src_prepare
	# docopt_s: disable static library
	sed -i \
		-e '/^project/s/0.6.2/0.6.3/' \
		-e '/docopt_s/s/^/#/' \
		CMakeLists.txt \
		|| die "sed failed"
}

src_configure() {
	local mycmakeargs=(
		-DWITH_TESTS=$(usex test)
		-DWITH_EXAMPLE=OFF
		-DUSE_BOOST_REGEX=OFF
	)
	cmake_src_configure
}

src_test() {
	cd "${BUILD_DIR}" || die
	${EPYTHON} run_tests || die "tests failed"
}
