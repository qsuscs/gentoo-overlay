# Copyright 2022 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit cmake python-single-r1

DESCRIPTION="Portable FPGA place and route tool"
HOMEPAGE="https://github.com/YosysHQ/nextpnr"

TESTS_COMMIT="ccc61e5ec7cc04410462ec3196ad467354787afb"
SRC_URI="
	https://github.com/YosysHQ/nextpnr/archive/refs/tags/${P}.tar.gz
	test? ( https://github.com/YosysHQ/nextpnr-tests/archive/${TESTS_COMMIT}.tar.gz -> ${PN}-tests-${TESTS_COMMIT}.tar.gz )
"
S="${WORKDIR}/${PN}-${P}"

LICENSE="ISC"

SLOT="0"

KEYWORDS="~amd64"

IUSE="qt5 +python test"
REQUIRED_USE="
	qt5? ( python )
	${PYTHON_REQUIRED_USE}
"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/tbb:=
	dev-libs/boost:=
	dev-cpp/eigen:3
	dev-cpp/json11
	python? (
		${PYTHON_DEPS}
	)
	qt5? (
		dev-qt/qtcore:5=
		dev-qt/qtwidgets:5=
		dev-qt/qtopengl:5=
		virtual/opengl
	)
"

# The C++ part of dev-python/pybind11 is header-only and version
# agnostic wrt. Python.
DEPEND="
	${RDEPEND}
	python? (
		dev-python/pybind11
	)
	test? (
		dev-cpp/gtest
	)
	sci-electronics/icestorm
"

BDEPEND="
	${PYTHON_DEPS}
	qt5? (
		dev-qt/qtcore:5=
	)
"

PATCHES=(
	"${FILESDIR}/unbundle.patch"
)

src_unpack() {
	default
	if use test; then
		rmdir "${S}/tests" || die
		mv "${WORKDIR}/${PN}-tests-${TESTS_COMMIT}" "${S}/tests" || die
	fi
}

src_configure() {
	local mycmakeargs=(
		-DPYTHON_EXECUTABLE="${PYTHON}"
		-DPYBIND11_NOPYTHON=yes
		-DARCH=ice40
		-DBUILD_GUI=$(usex qt5)
		-DBUILD_PYTHON=$(usex python)
		-DUSE_THREADS=yes
		-DBUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}

src_install() {
	dobin "${BUILD_DIR}/nextpnr-ice40"
	DOCS=( README.md docs/*.md )
	einstalldocs
}
