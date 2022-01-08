#!/bin/bash

packer init vmware-impish.pkr.hcl
packer build -force vmware-impish.pkr.hcl
cp metadata.json output/metadata.json
cd output
tar cvzf vmware-impish-arm64.box ./*
md5 vmware-impish-arm64.box
rm -f *.v* *.nvram metadata.json