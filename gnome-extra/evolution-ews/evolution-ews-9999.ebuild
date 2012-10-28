# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit db-use eutils flag-o-matic gnome2
if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

DESCRIPTION="Evolution module for connecting to Microsoft Exchange Web Services"
HOMEPAGE="http://www.gnome.org/projects/evolution/"

LICENSE="LGPL-2.1"
SLOT="0"
if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64"
fi
IUSE="kerberos" # doc

RDEPEND="
	dev-db/sqlite:3
	dev-libs/libical
	>=mail-client/evolution-${PV}:2.0[kerberos?]
	>=gnome-extra/evolution-data-server-${PV}[kerberos?]
	>=dev-libs/glib-2.28:2
	>=dev-libs/libxml2-2
	>=net-libs/libsoup-2.30:2.4
	>=x11-libs/gtk+-3:3
	kerberos? ( virtual/krb5 )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.5
	virtual/pkgconfig
"
# For now, this package has no gtk-doc documentation to build
#	doc? ( >=dev-util/gtk-doc-1.9 )

RESTRICT="test" # tests require connecting to an Exchange server

src_configure() {
	DOCS="ChangeLog NEWS README" # AUTHORS is empty
	G2CONF="${G2CONF} $(use_with kerberos krb5)"
	gnome2_src_configure
}
