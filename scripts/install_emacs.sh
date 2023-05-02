#!/bin/sh
[ -z "$EMACS_VERSION" ] && echo "Usage: EMACS_VERSION=25.1 install-emacs.sh or EMACS_VERSION=snapshot install-emacs.sh" && exit 1
[ -z "$EMACS_URL" ] && EMACS_URL="http://mirror.aarnet.edu.au/pub/gnu/emacs/"
[ -z "$EMACS_TMP" ] && EMACS_TMP="/tmp"

if [ "$EMACS_VERSION" != "snapshot" ]; then
    echo "curl $EMACS_URL/emacs-$EMACS_VERSION.tar.gz"
    curl $EMACS_URL/emacs-$EMACS_VERSION.tar.gz | tar xvz -C $EMACS_TMP
fi

echo "Installing Emacs ..."
if [ "$EMACS_VERSION" = "snapshot" ]; then
    cd $HOME/projs/emacs && mkdir -p $HOME/myemacs/snapshot && rm -rf $HOME/myemacs/snapshot/* && ./autogen.sh && ./configure CFLAGS=-no-pie --prefix=$HOME/myemacs/snapshot --without-x --without-dbus --without-sound --with-gnutls=no && make -j6 && make install
    echo "Emacs snapshot was installed!"
elif [ "$EMACS_VERSION" = "28.1" ]; then
    cd $EMACS_TMP/emacs-$EMACS_VERSION && mkdir -p $HOME/myemacs/$EMACS_VERSION && rm -rf $HOME/myemacs/$EMACS_VERSION/* && ./configure CFLAGS=-no-pie --prefix=$HOME/myemacs/$EMACS_VERSION --without-x --without-sound --with-gnutls=no --with-modules --with-native-compilation --without-compress-install && make -j6 && make install
else
    cd $EMACS_TMP/emacs-$EMACS_VERSION && mkdir -p $HOME/myemacs/$EMACS_VERSION && rm -rf $HOME/myemacs/$EMACS_VERSION/* && ./configure CFLAGS=-no-pie --prefix=$HOME/myemacs/$EMACS_VERSION --without-x --without-sound --with-gnutls=no --with-modules && make -j6 && make install
    rm -rf $EMACS_TMP/emacs-$EMACS_VERSION
    echo "Emacs $EMACS_VERSION was installed!"
fi
