# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit autotools

DESCRIPTION="A container init that is so simple it's effectively brain-dead"
HOMEPAGE="https://github.com/openSUSE/catatonit"
SRC_URI="https://github.com/openSUSE/catatonit/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default

	dosym "../../bin/catatonit" "${EPREFIX}/usr/libexec/podman/catatonit"
}
