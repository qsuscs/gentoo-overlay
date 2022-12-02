# Copyright 2022 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="Emoji, unicode and general character picker for rofi and rofi-likes"
HOMEPAGE="https://github.com/fdw/rofimoji"
SRC_URI="https://github.com/fdw/rofimoji/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
	|| ( x11-misc/rofi x11-misc/rofi-wayland )
	<dev-python/ConfigArgParse-2.0.0[${PYTHON_USEDEP}]
"

src_install() {
	distutils-r1_src_install
	doman src/picker/docs/rofimoji.1
}
