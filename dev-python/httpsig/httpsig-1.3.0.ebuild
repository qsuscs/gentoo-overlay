# Copyright 2023 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1 pypi

DESCRIPTION="Secure HTTP request signing using the HTTP Signature draft specification"
HOMEPAGE="https://github.com/ahknight/httpsig"

SRC_URI="$(pypi_sdist_url)"
KEYWORDS="~amd64"

LICENSE="MIT"

SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]"
RDEPEND="
	=dev-python/pycryptodome-3*[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
"
DOCS=(README.rst CHANGELOG.rst)

distutils_enable_tests pytest
