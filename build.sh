#!/bin/bash
set -e
cd "${0%/*}"
if [ ! -d decompiled ]
then
    ./download.sh
fi
rm -rf out
mkdir -p out
cp -r decompiled out/raw
find out/raw -name "*.gml" -exec sh -c 'cp "$1" "${1%.gml}.txt"' _ {} \;
cp -r static out
python generate.py
