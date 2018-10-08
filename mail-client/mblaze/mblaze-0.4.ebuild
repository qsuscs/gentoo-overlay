# Copyright 1999-2018 Gentoo Authors
# Copyright 2018 Thomas Schneider <qsx@qsx.re>
# Distributed under the terms of the ISC License

EAPI=6

DESCRIPTION="Unix utilities to deal with Maildir"
HOMEPAGE="https://github.com/chneukirchen/mblaze"
LICENSE="public-domain MIT"
if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/chneukirchen/mblaze"
else
	SRC_URI="https://github.com/chneukirchen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"

src_install() {
	emake PREFIX="${EPREFIX}/usr" DESTDIR="${D}" install
	dodoc NEWS.md VIOLATIONS.md filter.example mlesskey.example
	dodoc -r contrib
	dobin contrib/msearch
	doman contrib/msearch.1
}
