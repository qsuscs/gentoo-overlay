# Copyright 2020 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit cmake

DESCRIPTION="Experimental Neural Net speech coding for FreeDV"
HOMEPAGE="https://freedv.org/"
SRC_URI="
	https://github.com/drowe67/LPCNet/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://rowetel.com/downloads/deep/lpcnet_191005_v1.0.tgz
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cpu_flags_x86_avx2 cpu_flags_x86_avx cpu_flags_x86_sse4_1 cpu_flags_arm_neon"
REQUIRED_USE="
	cpu_flags_x86_avx2? ( cpu_flags_x86_avx )
	cpu_flags_x86_avx? ( cpu_flags_x86_sse4_1 )
"

RDEPEND="
	>=media-libs/codec2-0.9.2
"
DEPEND="
	${RDEPEND}
"

S="${WORKDIR}/LPCNet-${PV}"

src_configure () {
	local mycmakeargs=(
		"-DDISABLE_CPU_OPTIMIZATION=ON"
		"-DFETCHCONTENT_FULLY_DISCONNECTED=ON"
		"-DFETCHCONTENT_SOURCE_DIR_LPCNET=${WORKDIR}"
		"-DAVX2=$(usex cpu_flags_x86_avx2 ON OFF)"
		"-DAVX=$(usex cpu_flags_x86_avx ON OFF)"
		"-DSSE=$(usex cpu_flags_x86_sse4_1 ON OFF)"
		"-DNEON=$(usex cpu_flags_arm_neon ON OFF)"
	)
	cmake_src_configure
}
