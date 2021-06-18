# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop

# There seems to be no good way to manage deps that need to be downloaded.
RESTRICT=network-sandbox

DESCRIPTION="A window manager written in Nim (In Development)"
HOMEPAGE="https://github.com/avahe-kellenberger/nimdow"
SRC_URI="https://github.com/avahe-kellenberger/${PN}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	x11-base/xorg-proto
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXinerama
"

DEPEND="
	${RDEPEND}
	>=dev-lang/nim-1.4.8
"
RDEPEND="${DEPEND}"

src_compile() {
	nimble install -dy --noColor --verbose &&
	nimble release
}

src_install() {
	# Executable
	exeinto /usr/bin
	newexe "./bin/${PN}" "${PN}"

	# Default config file
	insinto "/usr/share/${PN}"
	doins "./config.default.toml"

	# Man page
	insinto "/usr/share/man/man1"
	doins "./doc/nimdow.1"

	# .desktop file
	domenu "${PN}.desktop"
}

