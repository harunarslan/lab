#!/bin/bash

THREADS="$(nproc)"
SERVICE="./build/chia_plot"
TEMP="/root/hall/temp/"
TEMP2="/root/hall/temp2/"
PLOT="/root/hall/plot/"
PCA="xch1q898yrj02vh0n2gtf6wzf2ddgly9gdn9r6ngqf7lfvwnfp7yrmgqc5twpl"
FPK="a5ea9d6e960ad6724ba1eeca9abcbb17f587142169db6a380d57b09189d8c1aab5ca2f2acf1d2b5e4007c499cdc543c6"
minute=1

while [ true ]
    do
        size=`du -s /root`
        intSize=$(echo $size | grep -o -E '[0-9]+')
        if [ $intSize -lt "293601280" ] ; then
        $SERVICE -n -1 -r $THREADS -t $TEMP -2 $TEMP2 -d $PLOT -c $PCA -f $FPK -k 32
        else 
        rm -r /root/hall/temp/*
        rm -r /root/hall/temp2/*
        sleep 3
        echo "Waiting for disk to empty ( $intSize / 293601280 ) Time Passed: $minute (M) " 
        fi
        sleep 60
        minute=$(($minute + 1))
    done