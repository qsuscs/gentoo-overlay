# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Heirloom development tools -- original Unix tools"
HOMEPAGE="http://heirloom.sourceforge.net/devtools.html"
SRC_URI="mirror://sourceforge/project/heirloom/${PN}/${PV}/${P}.tar.bz2"

LICENSE="BSD-4 CDDL"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

PATCHES=(
	# This code is just cursed and I don’t want to fix it.
	"${FILESDIR}/no-make.patch"
)

src_compile() {
	local -a makeflags
	makeflags=(
		# We need the path defines here as well as for install, since
		# the paths are compiled into some programs.
		BINDIR="${EPREFIX}/usr/bin/ccs"
		SUSBIN="${EPREFIX}/usr/bin/5bin/posix"
		LIBDIR="${EPREFIX}/usr/$(get_libdir)/ccs"
		CC="$(tc-getCC)"
		CFLAGS="${CFLAGS}"
		LDFLAGS="${LDFLAGS}"
		AR="$(tc-getAR)"
		RANLIB="$(tc-getRANLIB)"
	)
	# This yacc is needed to build lex and m4, so we need to have it for
	# the build host.  Also, the lex and m4 makefiles have race
	# conditions for their yacc files, so we need to build them with -j1.
	if tc-is-cross-compiler; then
		emake \
			"${makeflags[@]}" \
			CC="$(tc-getBUILD_CC)" \
			AR="$(tc-getBUILD_AR)" \
			RANLIB="$(tc-getBUILD_RANLIB)" \
			CFLAGS="" \
			LDFLAGS="" \
			SUBDIRS=yacc
		emake -j1 \
			"${makeflags[@]}" \
			SUBDIRS="lex m4"
		emake \
			"${makeflags[@]}" \
			SUBDIRS=yacc \
			mrproper
	fi
	emake \
		"${makeflags[@]}" \
		SUBDIRS=yacc
	emake -j1 \
		  "${makeflags[@]}" \
		  SUBDIRS="lex m4"
	# Yay, more race conditions.
	emake "${makeflags[@]}" makefiles
	emake "${makeflags[@]}"
}

src_install() {
	emake \
		STRIP=true \
		INSTALL=install \
		ROOT="${ED}" \
		BINDIR="${EPREFIX}/usr/bin/ccs" \
		SUSBIN="${EPREFIX}/usr/bin/5bin/posix" \
		LIBDIR="${EPREFIX}/usr/$(get_libdir)/ccs" \
		MANDIR="${EPREFIX}/usr/share/man/ccs" \
		install
	einstalldocs
}
