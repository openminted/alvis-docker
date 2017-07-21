#!/bin/bash

outdir=$PREFIX/share/$PKG_NAME
mkdir -p $outdir
mkdir -p $PREFIX/bin

mvn clean install
./install.sh $outdir


chmod +x $outdir/bin/alvisnlp
ln -s $outdir/bin/alvisnlp $PREFIX/bin/alvisnlp
