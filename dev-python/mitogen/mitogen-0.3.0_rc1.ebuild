# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

MY_PV="${PV/_rc/rc}"

DESCRIPTION="Distributed self-replicating programs in Python"
HOMEPAGE="https://mitogen.networkgenomics.com/"
SRC_URI="https://github.com/mitogen-hq/mitogen/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64"
IUSE="doc"

DOC_DEPEND='
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/alabaster[${PYTHON_USEDEP}]
	dev-python/sphinxcontrib-programoutput[${PYTHON_USEDEP}]
'

BDEPEND="
	doc? (
		 $(python_gen_any_dep "${DOC_DEPEND}")
	)
"

S="${WORKDIR}/mitogen-${MY_PV}"

# see tests/README.md, this is … complicated.
RESTRICT="test"

src_prepare() {
	default
	sed -i "/^VERSION/s/=.*/= \'${PV}\'/" docs/conf.py || die "sed failed"
}

python_check_deps() {
	use doc || return 0
	local p
	for p in ${DOC_DEPEND}; do
		has_version ${p//\$\{PYTHON_USEDEP\}/${PYTHON_USEDEP}} || return 1
	done
}

python_compile_all() {
	use doc || return 0
	pushd docs && build_sphinx "${PWD}" && popd || die
}
