# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7} )

inherit distutils-r1

DESCRIPTION="A CLI for the Stratis Project."
HOMEPAGE="https://github.com/stratis-storage/stratis-cli"
SRC_URI="https://github.com/stratis-storage/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/dbus-client-gen-0.4[${PYTHON_USEDEP}]
	>=dev-python/dbus-python-client-gen-0.5[${PYTHON_USEDEP}]
	~dev-python/justbytes-0.11[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]

"
RDEPEND="${DEPEND}"
