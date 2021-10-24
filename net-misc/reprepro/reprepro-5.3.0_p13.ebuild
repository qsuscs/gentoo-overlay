# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit bash-completion-r1

MY_PV="${PV%_*}"
S="${WORKDIR}/${PN}-${MY_PV}"

DESCRIPTION="Debian package repository producer"
HOMEPAGE="https://packages.debian.org/stable/reprepro"
SRC_URI="
	mirror://debian/pool/main/r/${PN}/${PN}_${MY_PV}.orig.tar.gz
	mirror://debian/pool/main/r/${PN}/${PN}_${MY_PV}-1.3.debian.tar.xz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE=""

RDEPEND="
	app-arch/bzip2:=
	app-arch/libarchive:=
	app-arch/lzma
	app-arch/zstd:=
	app-crypt/gpgme:=
	sys-libs/db:=
	sys-libs/zlib:=
"

DEPEND="${RDEPEND}"

PATCHES=(
	"${WORKDIR}"/debian/patches/0001-Bump-up-the-maxsize-on-a-fixed-size-C-buffer-to-avoi.patch
	"${WORKDIR}"/debian/patches/0002-Flush-stdout-stderr-before-calling-endhook.patch
	"${WORKDIR}"/debian/patches/0003-Add-Zstd-support.patch
)

src_install() {
	HTML_DOCS=( docs/manual.html )
	default

	pushd docs || die

	dodoc FAQ recovery short-howto

	docinto examples
	dodoc -r *.example *.py

	newbashcomp reprepro.bash_completion reprepro
	bashcomp_alias reprepro changestool
	insinto /usr/share/zsh/site-functions
	newins reprepro.zsh_completion _reprepro

	doman *.1

	popd || die
}
