# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit systemd toolchain-funcs

DESCRIPTION="Flexible ifup/ifdown implementation"
HOMEPAGE="https://github.com/ifupdown-ng/ifupdown-ng"

if [ "${PV}" = 9999 ]; then
	EGIT_REPO_URI="https://github.com/ifupdown-ng/ifupdown-ng"
	inherit git-r3
else
	SRC_URI="https://github.com/ifupdown-ng/ifupdown-ng/archive/${P}.tar.gz"
	S="${WORKDIR}/${PN}-${P}" # Why, Github.  Why?!
fi

LICENSE="ISC" # Not _exactly_, but will do I guess

SLOT="0"
KEYWORDS="~amd64"

IUSE="elibc_musl test"

RDEPEND="
	!elibc_musl? ( dev-libs/libbsd )
"
DEPEND="${RDEPEND}"

BDEPEND="
	app-text/scdoc
	test? ( dev-util/kyua )
	!elibc_musl? ( virtual/pkgconfig )
"

src_configure() {
	tc-export CC AR
}

src_compile() {
	local flags=()
	use elibc_musl || flags=(
		"LIBBSD_CFLAGS=$($(tc-getPKG_CONFIG) --cflags libbsd-overlay)"
		"LIBBSD_LIBS=$($(tc-getPKG_CONFIG) --cflags --libs libbsd-overlay)"
	)
	emake all docs "${flags[@]}"
}

src_install() {
	emake DESTDIR="${D}" install install_docs

	DOCS=( README.md doc/ADMIN-GUIDE.md )
	einstalldocs

	newconfd dist/openrc/networking.confd networking
	newinitd dist/openrc/networking.initd networking

	exeinto /usr/share/ifupdown-ng/sbin/
	doexe dist/debian/networking
	insinto /etc/default/
	newins dist/debian/networking.default networking
	systemd_dounit dist/debian/ifupdown-ng.networking.service
}
