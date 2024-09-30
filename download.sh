#!/bin/bash
set -e
cd "${0%/*}"

echo "Setting up..."
rm -rf decompiled
rm -rf download
mkdir download
cd download

echo "Downloading..."
wget -q $(curl -s -X POST -d '{"forceDownload": true}' -H "Content-Type: application/json" https://gamejolt.com/site-api/web/discover/games/builds/get-download-url/1501877 | jq -r .payload.url)
unzip -p undertale-yellow-v1.1.zip "Undertale Yellow v1_1/data.win" > data.win

echo "Decompiling..."
git clone https://github.com/krzys-h/UndertaleModTool.git --quiet
if [ -z "$UTMT_CLI_PATH" ]
then
    UTMT_CLI_PATH=../utmtcli/UndertaleModCli
fi
if [ ! -x "$UTMT_CLI_PATH" ]
then
    >&2 echo "File at $UTMT_CLI_PATH does not exist or is not executable."
    exit 1
fi
echo "Using $UTMT_CLI_PATH as the UndertaleModTool CLI executable."
$UTMT_CLI_PATH load data.win --scripts UndertaleModTool/UndertaleModTool/Scripts/Resource\ Unpackers/ExportAllCode.csx >/dev/null
mv Export_Code ../decompiled

echo "Cleaning up..."
cd ..
rm -rf download

echo "Done!"
