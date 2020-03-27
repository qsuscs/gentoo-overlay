# Copyright 2020 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_USE_SETUPTOOLS="rdepend"
inherit distutils-r1

DESCRIPTION="Python library & console tool for controlling Xiaomi smart appliances"

HOMEPAGE="https://github.com/rytilahti/python-miio"

SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-3+"

SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	dev-python/construct[${PYTHON_USEDEP}]
	>=dev-python/click-7[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/zeroconf[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
"

DOCS=( README.rst CHANGELOG.md docs )

distutils_enable_tests pytest
