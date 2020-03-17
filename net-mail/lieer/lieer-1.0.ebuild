# Copyright 2020 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )
DISTUTILS_USE_SETUPTOOLS=manual
inherit distutils-r1

DESCRIPTION="Fast email-fetching and two-way tag synchronization between notmuch and GMail"
HOMEPAGE="https://lieer.gaute.vetsj.com/"

SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-3+"

SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="
	dev-python/google-api-python-client[${PYTHON_USEDEP}]
	dev-python/oauth2client[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	net-mail/notmuch[python,${PYTHON_USEDEP}]
	${PYTHON_DEPS}
"
