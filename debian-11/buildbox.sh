#!/bin/bash

packer init vmware-bullseye.pkr.hcl
packer build -force vmware-bullseye.pkr.hcl
cp metadata.json output/metadata.json
cd output
tar cvzf vmware-bullseye-arm64.box ./*
md5 vmware-bullseye-arm64.box
rm -f *.v* *.nvram metadata.json