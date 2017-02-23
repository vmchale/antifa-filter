#!/bin/sh
cd src/ && zip -r wordfilter.zip * && mv wordfilter.zip ../target/ && cd -
./bash/crxmake src/ .wordfilter.pem && mv src.crx target/worldfilter.crx
