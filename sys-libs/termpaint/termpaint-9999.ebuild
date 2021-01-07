# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

EGIT_REPO_URI="https://github.com/termpaint/termpaint"
inherit git-r3 meson

DESCRIPTION="low level terminal interface library"
HOMEPAGE="https://github.com/termpaint/termpaint"
LICENSE="Boost-1.0"

SLOT="0"

IUSE="doc"

BDEPEND="
	doc? ( >=dev-python/sphinx-3.3.1 )
"

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
