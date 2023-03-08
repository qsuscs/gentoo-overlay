# Copyright 2023 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=8

inherit meson

DESCRIPTION="Handling of posix signals for Qt applications and libraries"
HOMEPAGE="https://github.com/textshell/posixsignalmanager"
SRC_URI="https://github.com/textshell/posixsignalmanager/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""

RDEPEND="
	dev-qt/qtcore:5=
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-qt/qtcore:5
"

PATCHES=(
	"${FILESDIR}/no-static-library.patch"
)
