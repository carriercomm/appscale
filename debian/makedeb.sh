#!/bin/sh

DIST=`lsb_release -c -s`
cd `dirname $0`/..

COMP=$1
RELEASE=$2
if [ -z "$RELEASE" ]; then
    RELEASE="test"
fi

if [ -e ./debian/rules.${COMP}.${DIST} ]; then
    :;
elif [ -e ./debian/rules.${COMP} ]; then
    :;
else
    echo "Please specify valid component name."
    exit 1
fi

# include APPSCALE_HOME_RUNTIME
. debian/appscale_install_functions.sh

REVNO=`git rev-parse HEAD`

if [ -e ./debian/control.${COMP}.${DIST} ]; then
    cp -v debian/control.${COMP}.${DIST} debian/control || exit 1
else
    cp -v debian/control.${COMP} debian/control || exit 1
fi

if [ -e ./debian/postinst.${COMP}.${DIST} ]; then
    cat debian/appscale_install_functions.sh > debian/postinst
    cat debian/postinst.${COMP}.${DIST} >> debian/postinst
elif [ -e ./debian/postinst.${COMP} ]; then
    cat debian/appscale_install_functions.sh > debian/postinst
    cat debian/postinst.${COMP} >> debian/postinst
else
    rm -f debian/postinst
fi

if [ -e ./debian/rules.${COMP}.${DIST} ]; then
    cp -v debian/rules.${COMP}.${DIST} debian/rules || exit 1
elif [ -e ./debian/rules.${COMP} ]; then
    cp -v debian/rules.${COMP} debian/rules || exit 1
fi

DESTDIR=`pwd`/debian/appscale-${COMP}
if [ -e ${DESTDIR} ]; then
    rm -rf ${DESTDIR}
fi

APPSCALE=${DESTDIR}${APPSCALE_HOME_RUNTIME}
fakeroot make -f debian/rules binary DIST=${DIST} DESTDIR=${DESTDIR} APPSCALE=${APPSCALE}
if [ $? = 0 ]; then
    mkdir -p debian/pool/${DIST}-${RELEASE}
    mv -v ../appscale-${COMP}*.deb debian/pool/${DIST}-${RELEASE} || exit 1
    rm -r ${DESTDIR}
fi
exit $?
