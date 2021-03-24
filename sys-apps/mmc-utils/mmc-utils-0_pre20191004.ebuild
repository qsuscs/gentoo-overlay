# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Userspace tools for MMC/SD devices"
HOMEPAGE="https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git/"

SRC_COMMIT="73d6c59af8d1bcedf5de4aa1f5d5b7f765f545f5"
SRC_URI="https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git/snapshot/mmc-utils-${SRC_COMMIT}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${SRC_COMMIT}"

LICENSE="GPL-2 BSD"
SLOT="0"

KEYWORDS="~amd64 ~arm64"

src_prepare() {
	sed -i 's/-Werror //' Makefile || die
	eapply_user
}

src_configure() {
	tc-export CC
}

src_install() {
	dosbin mmc
	doman man/mmc.1
}
