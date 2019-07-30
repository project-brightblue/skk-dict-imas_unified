#!/bin/bash

baseurl="https://github.com/project-brightblue"

# fetch
echo 'fetching dicts...'
git clone ${baseurl}/skk-dict-imascg.git
git clone ${baseurl}/skk-dict-imasml.git
git clone ${baseurl}/skk-dict-imassc.git

echo 'building...'

echo ';; -*- fundamental -*- ; coding: utf-8 -*-' > ./SKK-JISYO.imas.utf8

skkdic-expr2 ./skk-dict-imascg/SKK-JISYO.imascg.unified.euc + ./skk-dict-imasml/SKK-JISYO.imasml.unified.euc + ./skk-dict-imassc/SKK-JISYO.imassc.unified >> ./SKK-JISYO.imas.euc

# build UTF-8
cat ./skk-dict-imassc/SKK-JISYO.imassc.unified | iconv -f EUC-JP -t UTF-8 > ./skk-dict-imassc/SKK-JISYO.imassc.unified.utf8
skkdic-expr2 ./skk-dict-imascg/SKK-JISYO.imascg.unified.utf8 + ./skk-dict-imasml/SKK-JISYO.imasml.unified.utf8 + ./skk-dict-imassc/SKK-JISYO.imassc.unified.utf8 >> ./SKK-JISYO.imas.utf8

# clean
echo 'cleaning...'
rm -R ./skk-dict-imascg
rm -R ./skk-dict-imasml
rm -R ./skk-dict-imassc

echo 'done.'