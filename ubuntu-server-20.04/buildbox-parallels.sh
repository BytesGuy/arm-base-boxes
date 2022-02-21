#!/bin/bash

packer init parallels-focal.pkr.hcl
packer build -force parallels-focal.pkr.hcl
cp metadata-parallels.json output/metadata.json
prl_disk_tool compact --hdd output/*.pvm/*.hdd
cd output
tar cvzf parallels-focal-arm64.box ./*
md5 parallels-focal-arm64.box
rm -rf *.pvm metadata.json