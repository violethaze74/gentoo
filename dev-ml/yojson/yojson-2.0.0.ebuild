# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="JSON parsing and pretty-printing library for OCaml"
HOMEPAGE="https://github.com/ocaml-community/yojson"
SRC_URI="https://github.com/ocaml-community/yojson/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="examples +ocamlopt test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-lang/ocaml-4.02.3:=[ocamlopt=]
	>=dev-ml/seq-0.2.2:=[ocamlopt=]
"
DEPEND="${RDEPEND}"
BDEPEND=">=dev-ml/cppo-1.6.1
	test? ( dev-ml/alcotest )"

src_prepare() {
	default
	# let's not build this
	rm bench/dune yojson-bench.opam || die
}

src_install() {
	dune_src_install

	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
