#!/bin/bash

make
cp ./geniatagger $PREFIX/bin
cp -r ./models_chunking $PREFIX/bin
cp -r ./models_medline $PREFIX/bin
cp -r ./models_named_entity $PREFIX/bin
cp -r ./morphdic $PREFIX/bin
