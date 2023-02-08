# Copyright 2023 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )
inherit meson python-any-r1

DESCRIPTION="low level terminal interface library"
HOMEPAGE="https://github.com/termpaint/termpaint"
LICENSE="Boost-1.0"
SRC_URI="https://github.com/termpaint/termpaint/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"

SLOT="0"

IUSE="doc test tools"
RESTRICT="!test? ( test )"

BDEPEND="
	doc? ( >=dev-python/sphinx-3.3.1 )
	${PYTHON_DEPEND}
"
RDEPEND=""
DEPEND="
	dev-cpp/picojson
	test? ( dev-cpp/catch:0 )
"

PATCHES=(
	"${FILESDIR}/"0001-tests-Add-missing-after-INFO.patch
	"${FILESDIR}/"0002-termpaint_input-Add-missing-void-in-parameter-list.patch
	"${FILESDIR}/"0003-tests-Add-support-for-catch2-version-3.x.patch
	"${FILESDIR}/"0004-meson.build-Guard-tests-and-maintainer-targets-behin.patch
)

src_configure() {
	local emesonargs=(
		-Dbuild-tests=$(usex test true false)
		-Dmaintainer-mode=false

		-Dsystem-catch2=enabled
		-Dsystem-picojson=enabled

		-Dttyrescue-fexec-blob=false
		-Dttyrescue-path="${EPREFIX}/usr/libexec/termpaint"
		-Dttyrescue-install=true

		-Dtools-path=$(usex tools "${EPREFIX}/usr/libexec/termpaint" "")
	)
	meson_src_configure
}

src_compile() {
	meson_src_compile

	if use doc; then
		sphinx-build -b html "${S}/doc" "${WORKDIR}/html" || die "sphinx-build failed"
	fi
}

src_install() {
	meson_src_install

	use doc && HTML_DOCS=( "${WORKDIR}/html/." )
	einstalldocs
}
