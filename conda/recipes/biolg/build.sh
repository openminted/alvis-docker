#!/bin/bash

cd pcre-5.0
./configure
cd ../expat-2.0.0
./configure
cd ..
make
