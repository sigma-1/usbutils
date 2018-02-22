#!/bin/sh -e

cd usbhid-dump
./bootstrap
cd ..

#gtkdocize
autoreconf --install --symlink

MYCFLAGS="-g -Wall \
-Wmissing-declarations -Wmissing-prototypes \
-Wnested-externs -Wpointer-arith \
-Wpointer-arith -Wsign-compare -Wchar-subscripts \
-Wstrict-prototypes -Wshadow \
-Wformat=2 -Wtype-limits"

case "$CFLAGS" in
	*-O[0-9]*)
		;;
	*)
		MYCFLAGS="$MYCFLAGS -O2"
		;;
esac

libdir() {
	if [[ $(uname) == "Darwin" ]];then
		echo $(cd $1/$(gcc-7 -print-multi-os-directory); pwd)
	elif [[ $(uname) == "Linux" ]];then
		echo $(cd $1/$(gcc -print-multi-os-directory); pwd)
	fi
}

if [[ $(uname) == "Darwin" ]];then
	args="--prefix=/usr \
	--sysconfdir=/etc \
	--bindir=/usr/sbin \
	--sbindir=/usr/sbin \
	--libdir=$(libdir /usr/lib) \
	--enable-gtk-doc"
elif [[ $(uname) == "Linux" ]];then
	args="--prefix=/usr \
	--sysconfdir=/etc \
	--sbindir=/sbin \
	--libdir=$(libdir /usr/lib) \
	--with-rootlibdir=$(libdir /lib) \
	--libexecdir=/lib/udev \
	--with-selinux \
	--enable-gtk-doc"
fi

export CFLAGS="$CFLAGS $MYCFLAGS"
./configure $args $@
