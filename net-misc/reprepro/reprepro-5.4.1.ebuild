# Copyright 2023 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit autotools bash-completion-r1 db-use optfeature

DESCRIPTION="Debian package repository producer"
HOMEPAGE="https://packages.debian.org/stable/reprepro"
SRC_URI="mirror://debian/pool/main/r/${PN}/${PN}_${PV}.orig.tar.xz"

LICENSE="GPL-2 GPL-2+ MIT public-domain ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="bzip2 crypt +libarchive lzma test"
RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( libarchive )"

RDEPEND="
	sys-libs/db:=
	sys-libs/zlib:=

	bzip2? ( app-arch/bzip2:= )
	crypt? ( app-crypt/gpgme:= )
	libarchive? ( app-arch/libarchive:= )
	lzma? ( app-arch/lzma )
"

DEPEND="
	${RDEPEND}
	test? ( app-arch/libarchive[lzma] )
"

BDEPEND="
	test? (
		dev-util/shunit2
		app-arch/dpkg
		sys-libs/db
	)
"

PATCHES=(
	"${FILESDIR}/"tests-bash-sh-compat.patch
	"${FILESDIR}/"tests-no-apt.patch
	"${FILESDIR}/"uncompression_c-zlib-return.patch
)

src_prepare() {
	default
	if use test; then
		local db_ver=$(db_findver sys-libs/db)
		sed -i \
			-e "s/db_verify/db${db_ver}_verify/" \
			-e "s/db_dump/db${db_ver}_dump/" \
			-- tests/{multiversion.sh,shunit2-helper-functions.sh} \
			|| die "sed failed"
	fi
	eautoreconf
}

src_configure() {
	econf \
		$(use_with bzip2 libbz2) \
		$(use_with crypt libgpgme) \
		$(use_with libarchive) \
		$(use_with lzma liblzma)
}

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

	popd || die
}

pkg_postinst() {
	optfeature "zstd compression" app-arch/zstd
	optfeature "lzip compression" app-arch/lunzip
}
