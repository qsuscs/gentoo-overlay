# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit git-r3 autotools

DESCRIPTION="Tool from Rockchip to communicate with Rockusb devices"
HOMEPAGE="http://opensource.rock-chips.com/wiki_Rkdeveloptool https://github.com/rockchip-linux/rkdeveloptool"
EGIT_REPO_URI="https://github.com/rockchip-linux/rkdeveloptool.git"

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
