#!/bin/bash

packer init vmware-buster.pkr.hcl
packer build -force vmware-buster.pkr.hcl
cp metadata.json output/metadata.json
cd output
tar cvzf vmware-buster-arm64.box ./*
md5 vmware-buster-arm64.box
rm -rf *.v* *.nvram metadata.json