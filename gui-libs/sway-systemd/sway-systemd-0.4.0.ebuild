# Copyright 2023 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=8

PYTHON_COMPAT=( python3_{10..11} )
inherit meson python-single-r1

DESCRIPTION="Systemd integration for Sway session"
HOMEPAGE="https://github.com/alebastr/sway-systemd"
SRC_URI="https://github.com/alebastr/sway-systemd/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	sys-apps/systemd
"
RDEPEND="
	${DEPEND}
	${PYTHON_DEPS}
	sys-apps/dbus

	$(python_gen_cond_dep '
		dev-python/dbus-next[${PYTHON_USEDEP}]
		dev-python/i3ipc[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/tenacity[${PYTHON_USEDEP}]
		dev-python/python-xlib[${PYTHON_USEDEP}]
	')
"

src_prepare() {
	default
	python_fix_shebang src
}
