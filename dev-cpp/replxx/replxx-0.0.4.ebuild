# Copyright 2023 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL
EAPI=8

inherit cmake

DESCRIPTION="A readline and libedit replacement"
HOMEPAGE="https://github.com/AmokHuginnsson/replxx"
SRC_URI="https://github.com/AmokHuginnsson/replxx/archive/refs/tags/release-${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-release-${PV}"

LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64"

src_configure() {
	local mycmakeargs=(
		-DREPLXX_BUILD_EXAMPLES=OFF
		-DREPLXX_BUILD_PACKAGE=OFF
		-DBUILD_SHARED_LIBS=ON
	)
	cmake_src_configure
}

src_install() {
	DOCS=( README.md examples )
	cmake_src_install
}
