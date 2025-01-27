# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="HTTP request/response parser for python in C"
HOMEPAGE="
	https://github.com/benoitc/http-parser/
	https://pypi.org/project/http-parser/
"
SRC_URI="
	https://github.com/benoitc/http-parser/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="examples"

BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

python_configure_all() {
	cython -3 http_parser/parser.pyx || die
}

python_install_all() {
	local DOCS=( README.rst )
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi

	distutils-r1_python_install_all
}
