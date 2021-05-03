# Copyright 2020 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

WX_GTK_VER="3.0-gtk3"
inherit cmake wxwidgets

DESCRIPTION="FreeDV is a Digital Voice mode for HF radio."
HOMEPAGE="https://freedv.org/"
SRC_URI="https://github.com/drowe67/freedv-gui/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	media-libs/alsa-lib
	media-libs/codec2
	media-libs/hamlib
	media-libs/libao
	media-libs/libsamplerate
	media-libs/libsndfile
	media-libs/lpcnet-freedv
	media-libs/portaudio
	media-libs/speexdsp
	media-sound/gsm
	media-sound/sox
	x11-libs/wxGTK:${WX_GTK_VER}[X]
"
DEPEND="
	${RDEPEND}
"

S="${WORKDIR}/${PN}-gui-${PV}"

src_configure () {
	setup-wxwidgets

	local mycmakeargs=(
		"-DUSE_INTERNAL_CODEC2=OFF"
		"-DUSE_STATIC_SPEEXDSP=OFF"
		"-DUSE_STATIC_DEPS=OFF"
		"-DWXCONFIG=${WX_CONFIG}"
	)
	cmake_src_configure
}
