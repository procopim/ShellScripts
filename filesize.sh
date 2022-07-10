#!/bin/sh
# a simple function that returns size of a file in MB
# current config to have filesize.sh in the cwd
# must chmod to make filesize.sh executable


echo "Calling filesize.sh"
FILE=$1
FILESIZE=`stat --format=%s "$1"`
FILESIZEMB=`expr "$FILESIZE" / 100000`
echo "$FILESIZEMB MB"