# Copyright 2020 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
inherit distutils-r1

DESCRIPTION="Powerful and Lightweight Python Tree Data Structure"
HOMEPAGE="https://github.com/c0fec0de/anytree"

SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="Apache-2.0"

SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	dev-python/setuptools_scm[${PYTHON_USEDEP}]
	${BDEPEND}
"
RDEPEND="
	dev-python/six[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
"

distutils_enable_sphinx docs dev-python/sphinxcontrib-napoleon
distutils_enable_tests nose

python_prepare_all() {
	# this would install LICENSE to /usr/ otherwise, and we don’t need
	# it anyway
	sed -i '/data_files/d' setup.py || die

	distutils-r1_python_prepare_all
}
