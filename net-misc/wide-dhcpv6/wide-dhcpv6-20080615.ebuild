# Copyright 2020 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit autotools prefix systemd

DESCRIPTION="WIDE project DHCPv6 client and server"
HOMEPAGE="https://wide-dhcpv6.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	sys-devel/bison
	sys-devel/flex
"

PATCHES=(
	"${FILESDIR}/0001-Fix-manpages.patch"
	"${FILESDIR}/0002-Don-t-strip-binaries.patch"
	"${FILESDIR}/0003-Close-inherited-file-descriptors.patch"
	"${FILESDIR}/0004-GNU-libc6-fixes.patch"
	"${FILESDIR}/0005-Update-ifid-on-interface-restart.patch"
	"${FILESDIR}/0006-Add-new-feature-dhcp6c-profiles.patch"
	"${FILESDIR}/0007-Adding-ifid-option-to-the-dhcp6c.conf-prefix-interfa.patch"
	"${FILESDIR}/0008-Close-file-descriptors-on-exec.patch"
	"${FILESDIR}/0009-Fix-renewal-of-IA-NA.patch"
	"${FILESDIR}/0010-Call-client-script-after-interfaces-have-been-update.patch"
	"${FILESDIR}/0011-resolv-warnings-so-as-to-make-blhc-and-gcc-both-happ.patch"
	"${FILESDIR}/0012-fix-a-redefined-YYDEBUG-warning-of-gcc-for-the-code-.patch"
	"${FILESDIR}/0013-added-several-comments-examples-by-Stefan-Sperling.patch"
	"${FILESDIR}/0014-Support-to-build-on-kFreeBSD-n-GNU-Hurd-platform.patch"
	"${FILESDIR}/0015-a-bit-info-to-logger-when-get-OPTION_RECONF_ACCEPT.patch"
	"${FILESDIR}/0016-fix-typo-in-dhcp6c.8-manpage.patch"
	"${FILESDIR}/0017-Remove-unused-linking-with-libfl.patch"
	"${FILESDIR}/0018-dhcpv6-ignore-advertise-messages-with-none-of-reques.patch"
	"${FILESDIR}/0019-Server-should-not-bind-control-port-if-there-is-no-s.patch"
	"${FILESDIR}/0020-Adding-option-to-randomize-interface-id.patch"
	"${FILESDIR}/0021-Fix-parallel-building-race-condition.patch"
	"${FILESDIR}/0021-Make-sla-len-config-optional.patch"
	"${FILESDIR}/0022-Make-sla-id-config-optional.patch"
)

src_prepare() {
	rm configure cfparse.c cftoken.c y.tab.h || die
	cp "${FILESDIR}/wide-dhcp6c.init" . || die
	hprefixify wide-dhcp6c.init
	default
	eautoreconf
}

src_configure() {
	econf \
		--with-localdbdir="${EPREFIX}/var/lib/dhcpv6" \
		--sysconfdir="${EPREFIX}/etc/wide-dhcpv6"
}

src_install() {
	# make install doesn’t honor DESTDIR
	doman *.5 *.8
	dosbin dhcp6c dhcp6s dhcp6relay dhcp6ctl
	keepdir /var/lib/dhcpv6
	insinto /etc/wide-dhcpv6
	doins dhcp6c.conf.sample dhcp6s.conf.sample
	dodoc "${FILESDIR}/README.gentoo"
	systemd_newunit "${FILESDIR}/dhcp6c-AT.service" "dhcp6c@.service"
	systemd_newunit "${FILESDIR}/dhcp6s-AT.service" "dhcp6s@.service"
	newconfd "${FILESDIR}/wide-dhcp6c.confd" wide-dhcp6c
	newinitd wide-dhcp6c.init wide-dhcp6c
	einstalldocs
}

pkg_postinst() {
	elog "To control dhcp6c/dhcp6s with dhcp6ctl(8), you need to"
	elog "create a control key each, for example:"
	elog "umask 077 && \\"
	elog "openssl rand -base64 -out /etc/wide-dhcpv6/dhcp6cctlkey 32 && \\"
	elog "openssl rand -base64 -out /etc/wide-dhcpv6/dhcp6sctlkey 32"
}
