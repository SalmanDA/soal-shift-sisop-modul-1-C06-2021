#!/bin/bash

a=$(date +"%d%m%Y")

unzip -P $a Koleksi.zip

rm -r Koleksi.zip
