# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS=rdepend
inherit distutils-r1

DESCRIPTION="Python package to manage a Sony DPT-RP1"
HOMEPAGE="https://github.com/janten/dpt-rp1-py"

SRC_URI="https://github.com/janten/dpt-rp1-py/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="MIT"

SLOT="0"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="dev-python/setuptools_scm[${PYTHON_USEDEP}]"
RDEPEND="
	>=dev-python/httpsig-1.1.2[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18.4[${PYTHON_USEDEP}]
	>=dev-python/pbkdf2-1.3[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.22[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/anytree[${PYTHON_USEDEP}]
	dev-python/fusepy[${PYTHON_USEDEP}]
	dev-python/zeroconf[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
"
DOCS=(README.md docs/linux-ethernet-over-usb.md samples)
