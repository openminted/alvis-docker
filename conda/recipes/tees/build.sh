#!/bin/bash

outdir=$PREFIX/share/$PKG_NAME
mkdir -p $outdir
mkdir -p $PREFIX/bin

python configure.py $outdir

chmod +x $outdir/train.py
ln -s $outdir/train.py $PREFIX/bin/train

chmod +x $outdir/classify.py
ln -s $outdir/classify.py $PREFIX/bin/classify

