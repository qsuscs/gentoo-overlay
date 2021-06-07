# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A miniature early Macintosh emulator"
HOMEPAGE="https://www.gryphel.com/c/minivmac/"
SRC_URI="https://www.gryphel.com/d/${PN}/${P}/${P}.src.tgz"

S="${WORKDIR}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm"

IUSE="+alsa"

RDEPEND="
	alsa? ( media-libs/alsa-lib )
	x11-libs/libX11
"
DEPEND="${RDEPEND}"

src_configure() {
	# Oh dear.
	sed -i -e "s/\"gcc\"/\"$(tc-getCC)\"/" setup/BLDUTIL3.i || die
	sed -i -e "s/strip --strip-unneeded/true/" \
		-e "s/\" -O.\"/\" ${CFLAGS} ${LDFLAGS}\"/" \
		-e "s: -L/usr/X11R6/lib::" \
		setup/WRBGCFLS.i || die
	$(tc-getBUILD_CC) setup/tool.c -o setup_t || die
	local target
	if use amd64; then
		target=lx64
	elif use arm; then
		target=larm
	else
		die "Unsupported target"
	fi
	./setup_t -t ${target} \
			  -sound $(usex alsa 1 0) \
			  > setup.sh || die
	bash setup.sh || die
}

src_install() {
	dobin minivmac
	# The README.txt is quite pointless.
}
