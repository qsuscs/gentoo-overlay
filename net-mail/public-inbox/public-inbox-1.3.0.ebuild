# Copyright 2020 Thomas Schneider <qsx@chaotikum.eu>
# Licensed under the EUPL

EAPI=7

DIST_EXAMPLES=(examples sa_config scripts)
inherit perl-module eutils

DESCRIPTION="an 'archives first' approach to mailing lists"
HOMEPAGE="https://public-inbox.org/README.html"

SRC_URI="https://public-inbox.org/public-inbox.git/snapshot/${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="AGPL-3+"

SLOT="0"

DEPEND="
	virtual/perl-Digest-SHA
	dev-perl/Email-MIME
	virtual/perl-Encode
	dev-perl/URI
	virtual/perl-File-Path
	>=virtual/perl-File-Temp-0.19
	virtual/perl-Getopt-Long
	virtual/perl-Exporter
	virtual/perl-ExtUtils-MakeMaker
"

RDEPEND="${DEPEND}
	dev-perl/DBD-SQLite
	>=dev-vcs/git-2.6
"

pkg_postinst() {
	elog "To use optional features, install:"
	optfeature "HTML/Atom generation" dev-perl/Plack
	optfeature "broken, mostly historical mails" dev-perl/TimeDate
	optfeature "HTTP search" dev-perl/Search-Xapian
	optfeature "public-inbox-compact(1)" dev-libs/xapian
	optfeature "background daemons, when not using systemd" dev-perl/Net-Server
	optfeature "speeding up process spawning" dev-perl/Inline-C
}
