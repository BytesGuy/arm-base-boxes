#!/bin/bash

packer init vmware-noble.pkr.hcl
packer build -force vmware-noble.pkr.hcl


cp metadata.json output/metadata.json
cd output
tar cvzf vmware-noble-arm64.box ./*
md5 vmware-noble-arm64.box
rm -f *.v* *.nvram metadata.json