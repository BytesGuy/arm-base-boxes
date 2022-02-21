#!/bin/bash

packer init vmware-focal.pkr.hcl
packer build -force vmware-focal.pkr.hcl
cp metadata.json output/metadata.json
cd output
tar cvzf vmware-focal-arm64.box ./*
md5 vmware-focal-arm64.box
rm -f *.v* *.nvram metadata.json