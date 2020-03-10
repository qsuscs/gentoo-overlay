# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools systemd

MY_PV="3.8.C"
DESCRIPTION="Extended implementation of the Berkeley LPR print spooler"
HOMEPAGE="http://www.lprng.com/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="|| ( GPL-2 Artistic )"
SLOT="0"
KEYWORDS="~amd64"
IUSE="kerberos nls ssl"

RDEPEND="sys-process/procps
	ssl? ( dev-libs/openssl )
	!>=net-print/cups-1.6.2-r4[-lprng-compat]
	!<net-print/cups-1.6.2-r4
	acct-group/lp
	kerberos? ( app-crypt/mit-krb5 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${PN}-${MY_PV}

PATCHES=(
	"${FILESDIR}"/openssl-1.1.patch
)

DOCS=(ChangeLog CHANGES NEWS README README.SSL.SECURITY)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	myeconfargs=(
		$(use_enable nls)
		$(use_enable kerberos)
		$(use_enable kerberos kerberos_checks)
		$(use_enable ssl)
		--with-userid=lp
		--with-groupid=lp
		--with-config_subdir=lprng
		--with-lockfile="${EPREFIX}"/run/lprng/lpd
		--with-unix_socket_path="${EPREFIX}"/run/lprng/socket
	)
	econf ${myeconfargs[@]}
}

src_install() {
	default

	dodir /var/spool/lpd
	diropts -m 700 -o lp -g lp
	dodir /var/spool/lpd/lp
	keepdir /var/spool/lpd /var/spool/lpd/lp

	newinitd "${FILESDIR}"/lpd-init lpd
	systemd_dounit "${FILESDIR}"/lpd.service
}
