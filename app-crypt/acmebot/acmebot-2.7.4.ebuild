# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )
inherit python-r1 systemd

DESCRIPTION="Certificate manager bot using ACME protocol"
HOMEPAGE="https://github.com/plinss/acmebot"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/plinss/acmebot.git"
	inherit git-r3
else
	SRC_URI="https://github.com/plinss/acmebot/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/appdirs-1.4.3[${PYTHON_USEDEP}]
	>=dev-python/pyparsing-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-16.8[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-17.5.0[${PYTHON_USEDEP}]
	>=dev-python/pydns-3.1.0:3[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.1.4[${PYTHON_USEDEP}]
	>=dev-python/asn1crypto-0.24.0[${PYTHON_USEDEP}]
	>=app-crypt/acme-0.25.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.1[${PYTHON_USEDEP}]
"
DEPEND=""

src_prepare() {
	default

	sed -i 's:/var/local:/var/lib:' \
		acmebot acmebot.example.{json,yaml} \
		|| die "sed failed"

	sed "s:@PV@:${PV}:" "${FILESDIR}/acmebot.service.in" > acmebot.service \
		|| die "sed failed"

	# I do not see any incompatibility to pyOpenSSL 20.
	# https://github.com/plinss/acmebot/issues/47
	sed -i '/^pyOpenSSL/s/,.*//' requirements.txt || die "sed failed"
}

src_install() {
	python_foreach_impl python_doscript acmebot

	insinto /etc/acmebot
	doins acmebot.example.{json,yaml}

	insinto /etc/logrotate.d
	doins logrotate.d/acmebot

	systemd_dounit acmebot.service "${FILESDIR}/acmebot.timer"

	dodoc README.rst

	keepdir /var/lib/acmebot
}
