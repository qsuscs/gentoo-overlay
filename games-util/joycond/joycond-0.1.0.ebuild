# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake systemd udev

DESCRIPTION="Userspace daemon to combine joy-cons from the hid-nintendo kernel driver"
HOMEPAGE="https://github.com/DanielOgorchock/joycond"
SRC_URI="https://github.com/DanielOgorchock/joycond/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
# this is still experimental
# KEYWORDS="~amd64"

RDEPEND="
	dev-libs/libevdev
	virtual/libudev
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/systemd-service.patch"
)

src_prepare() {
	cmake_src_prepare
	sed -i 's/-Werror//' CMakeLists.txt || die "sed failed"
}

src_install() {
	einstalldocs
	dobin "${BUILD_DIR}/joycond"
	udev_dorules udev/*.rules
	systemd_dounit systemd/joycond.service
}

pkg_postinst() {
	udev_reload
}
