# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
inherit distutils-r1 optfeature

DESCRIPTION="Breezy is a friendly powerful distributed version control system."
HOMEPAGE="https://www.breezy-vcs.org/"
SRC_URI="https://launchpad.net/brz/$(ver_cut 1-2)/${PV}/+download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64"
IUSE="doc"

RDEPEND="
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/patiencediff[${PYTHON_USEDEP}]
"

BDEPEND="
	doc? (
		 $(python_gen_any_dep '
			 dev-python/sphinx[${PYTHON_USEDEP}]
			 dev-python/sphinx-epytext[${PYTHON_USEDEP}]
		 ')
	)
"

DOCS=( README.rst NEWS TODO )

python_compile_all() {
	use doc || return 0
	emake docs
}

python_install_all() {
	einstalldocs
	if use doc; then
		local i
		for i in developers en; do
			docinto html/${i}
			dodoc -r doc/${i}/_build/html/.
		done
		docompress -x "/usr/share/doc/${PF}/html"
	fi
	mv "${D}/usr/man" "${D}/usr/share/" || die
}

pkg_postinst() {
	elog "For optional features, please install:"
	optfeature "Git support" dev-python/dulwich
	optfeature "fastimport support" dev-python/python-fastimport
	optfeature "GitHub integration" dev-python/PyGithub
	optfeature "GitLab integration" dev-vcs/python-gitlab
	optfeature "GPG signatures" "app-crypt/gpgme[python]"
	optfeature "SSH transfer" net-misc/openssh dev-python/paramiko
	optfeature "Kerberos authentication" dev-python/pykerberos
}
