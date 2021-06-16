# Copyright 2021 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/fatih/color v1.7.0"
	"github.com/fatih/color v1.7.0/go.mod"
	"github.com/mattn/go-colorable v0.0.9"
	"github.com/mattn/go-colorable v0.0.9/go.mod"
	"github.com/mattn/go-isatty v0.0.4"
	"github.com/mattn/go-isatty v0.0.4/go.mod"
	"github.com/nwidger/jsoncolor v0.0.0-20170215171346-75a6de4340e5"
	"github.com/nwidger/jsoncolor v0.0.0-20170215171346-75a6de4340e5/go.mod"
	"github.com/pkg/errors v0.8.0"
	"github.com/pkg/errors v0.8.0/go.mod"
	"golang.org/x/sys v0.0.0-20210616094352-59db8d763f22"
	"golang.org/x/sys v0.0.0-20210616094352-59db8d763f22/go.mod"
)

go-module_set_globals

DESCRIPTION="Make JSON greppable!"
HOMEPAGE="https://github.com/tomnomnom/gron"
SRC_URI="
	https://github.com/tomnomnom/gron/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

LICENSE="MIT BSD-2"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/go-mod.patch"
)

src_compile() {
	go build || die "go build failed"
}

src_install() {
	HTML_DOCS=( docs/. )
	DOCS=( *.mkd )
	einstalldocs

	dobin gron
}
