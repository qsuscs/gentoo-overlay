# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit autotools

HASH="46bb4c073624226c3f05b37b9ecc50bbcf543f5a"

DESCRIPTION="Tool from Rockchip to communicate with Rockusb devices"
HOMEPAGE="http://opensource.rock-chips.com/wiki_Rkdeveloptool https://github.com/rockchip-linux/rkdeveloptool"
SRC_URI="https://github.com/rockchip-linux/rkdeveloptool/archive/${HASH}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${HASH}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	virtual/libusb:1
"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

DOCS=( Readme.txt 99-rk-rockusb.rules parameter_gpt.txt )

src_prepare() {
	sed -i 's/-Werror//' Makefile.am || die "sed failed"

	eapply_user
	eautoreconf
}
