# Copyright 2020 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit cmake xdg-utils

DESCRIPTION="Twinkle is a SIP-based VoIP client."
HOMEPAGE="http://twinkle.dolezel.info"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/LubosD/twinkle"
	inherit git-r3
else
	SRC_URI="https://github.com/LubosD/twinkle/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="alsa dbus g729 gsm +qt5 speex"

RDEPEND="
	dev-libs/ucommon:=
	media-libs/ccrtp
	dev-libs/libxml2
	media-libs/libsndfile
	sys-apps/file
	sys-libs/readline:=

	qt5? (
		dev-qt/qtdeclarative:=[widgets]
		dbus? ( dev-qt/qtdbus:= )
	)

	alsa? ( media-libs/alsa-lib )
	speex? ( media-libs/speex )
	g729? ( media-libs/bcg729 )
	gsm? ( media-sound/gsm )
"

DEPEND="${RDEPEND}"

BDEPEND="
	qt5? ( dev-qt/linguist-tools )
	sys-devel/bison
	sys-devel/flex
"

src_configure() {
	local mycmakeargs=(
		-DWITH_QT5=$(usex qt5)
		-DWITH_DBUS=$(usex dbus)
		-DWITH_ZRTP=OFF # not ported yet
		-DWITH_ALSA=$(usex alsa)
		-DWITH_SPEEX=$(usex speex)
		-DWITH_ILBC=OFF # requires old version
		-DWITH_G729=$(usex g729) # broken as well
		-DWITH_GSM=$(usex gsm)
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
