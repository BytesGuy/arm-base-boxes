#!/bin/bash

packer init parallels-bullseye.pkr.hcl
packer build -force parallels-bullseye.pkr.hcl
cp metadata-parallels.json output/metadata.json
prl_disk_tool compact --hdd output/*.pvm/*.hdd
cd output
tar cvzf parallels-bullseye-arm64.box ./*
md5 parallels-bullseye-arm64.box
rm -rf *.pvm metadata.json