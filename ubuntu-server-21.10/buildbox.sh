#!/bin/bash

packer init vmware-impish.pkr.hcl
packer build -force vmware-impish.pkr.hcl
cp metadata.json output/metadata.json
tar cvzf output/vmware-impish-arm64.box output/*
md5 output/vmware-impish-arm64.box
rm -f output/*.v* output/*.nvram output/metadata.json