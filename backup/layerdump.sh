#! /bin/bash
set -x
#:: ICS SF layerdump batch
#::
#:: [usage]
#::
#:: $> ./SF_layerdump_all [IS_RAW] [DUMP_ID]
#::
#:: IS_RAW: 0 for PNG and 1 for RAW (default 0)
#:: DUMP_ID: layer identity to dump, or -1 for all (defulat -1)

raw=$1
layerdump=$2

if [ "${raw}x" = "x" ] ; then
	raw=0
fi

if [ "${layerdump}x" = "x" ] ; then
	layerdump=-1
fi

adb shell setprop debug.sf.layerdump.raw $raw
adb shell setprop debug.sf.layerdump $layerdump
adb shell dumpsys SurfaceFlinger > /local/SF_layerdump_all.log
adb shell mkdir /data/SF_dump

adb shell mv /data/*.png /data/SF_dump
adb shell mv /data/*.i420 /data/SF_dump
adb shell mv /data/*.yv12 /data/SF_dump
adb shell mv /data/*.RGBA /data/SF_dump
adb shell mv /data/*.RGB565 /data/SF_dump

mkdir SF_layerdump_all
adb pull /data/SF_dump /local/SF_layerdump_all/
adb shell rm /data/SF_dump/*



