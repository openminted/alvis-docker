#!/bin/bash

sh  install-tagger.sh
mv $SRC_DIR/cmd/cmd/* $SRC_DIR/cmd
rm -rf $SRC_DIR/cmd/cmd

gunzip < english-par-linux-3.2-utf8.bin.gz > $SRC_DIR/lib/english-utf8.par