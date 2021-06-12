# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit autotools

DESCRIPTION="The Free and Open Source Software for Partition Imaging and Cloning"
HOMEPAGE="https://partclone.org/"

SRC_URI="mirror://sourceforge/project/${PN}/unstable/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64"

IUSE="fuse +extfs reiser4 nilfs2 ntfs +ncurses"

RDEPEND="
	fuse? ( sys-fs/fuse:0 )
	extfs? ( sys-fs/e2fsprogs )
	reiser4? ( sys-fs/reiser4progs )
	nilfs2? ( sys-fs/nilfs-utils )
	ntfs? ( sys-fs/ntfs3g:= )
	ncurses? ( sys-libs/ncurses:= )
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable fuse)
		$(use_enable extfs)
		$(use_enable reiser4)
		$(use_enable nilfs2)
		$(use_enable ntfs)

		$(use_enable ncurses ncursesw)

		# broken
		--disable-reiserfs
		# missing dependencies
		--disable-ufs
		--disable-vmfs
		--disable-jfs

		# no dependencies
		--enable-xfs
		--enable-hfsp
		--enable-apfs
		--enable-fat
		--enable-exfat
		--enable-f2fs
		--enable-btrfs # only needs libblkid, which is in util-linux, which is in @system
		--enable-minix

		--disable-static

		# ???
		--disable-mtrace
		--disable-fs-test
	)
	econf "${myconf[@]}"
}
