#!/bin/bash

#awk 'BEGIN {FS=","}; {print "INSERT INTO cache_RLibRIntMapping VALUES(",$2,",",$5,");"}' RawInterface.init | sort | uniq > cache_RLibRIntMapping.init
awk 'BEGIN {FS=","}; {print "INSERT INTO cache_RIntNames VALUES(",$2,");"}' RawInterface.init | sort | uniq >cache_RIntNames.init

