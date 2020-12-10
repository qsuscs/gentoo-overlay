# Copyright 2020 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Unix utilities to deal with Maildir"
HOMEPAGE="https://github.com/leahneukirchen/mblaze"
LICENSE="public-domain MIT"
if [[ ${PV} = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/leahneukirchen/mblaze"
else
	SRC_URI="https://github.com/leahneukirchen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

IUSE="zsh-completion"

SLOT="0"

DOCS=(NEWS.md VIOLATIONS.md filter.example mlesskey.example)

src_configure() {
	tc-export CC
}

src_install() {
	emake PREFIX="${EPREFIX}/usr" DESTDIR="${D}" install
	einstalldocs

	dobin contrib/msearch
	doman contrib/msearch.1
	rm contrib/msearch{,.1} || die
	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions/
		doins contrib/_mblaze
		rm contrib/_mblaze || die
	fi
	dodoc -r contrib
}
