#!/bin/bash
rm -rf decompiled
mkdir download
cd download
wget $(curl -X POST -d '{"forceDownload": true}' -H "Content-Type: application/json" https://gamejolt.com/site-api/web/discover/games/builds/get-download-url/1501877 | jq -r .payload.url)
unzip -p undertale-yellow-v1.1.zip "Undertale Yellow v1_1/data.win" > data.win
git clone https://github.com/krzys-h/UndertaleModTool.git
wget https://github.com/krzys-h/UndertaleModTool/releases/download/bleeding-edge/CLI-ubuntu-latest-Release-isBundled-true.zip
unzip CLI-ubuntu-latest-Release-isBundled-true.zip
./UndertaleModCli load data.win --scripts UndertaleModTool/UndertaleModTool/Scripts/Resource\ Unpackers/ExportAllCode.csx
mv Export_Code ../decompiled
cd ..
rm -rf download
