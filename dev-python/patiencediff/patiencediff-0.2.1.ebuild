# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1

DESCRIPTION="Python implementation of the patiencediff algorithm"
HOMEPAGE="https://pypi.org/project/patiencediff/"

SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-2"

SLOT="0"

distutils_enable_tests setup.py
