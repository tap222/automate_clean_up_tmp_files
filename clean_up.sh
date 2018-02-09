#!/bin/bash
usage="Usage: dir_diff.sh [30]" #Here you want to delete files of how many old days e.g. I have taken here 30 days old

if [! "$1"]

then

echo$usage #when you run script then it will show you the files which are present in directory

exit1

fi

now=$(date +%s) #define date of today

rm -r /var/tmp/ | grep "^d" | while read f; do #delete all the temp files which are 30 days old and here you have to 

dir_date=`echo $f | awk '{print $6}'` 

difference=$(( ( $now - $(date -d "$dir_date" +%s) ) / (24 * 60 * 60 ) )) # to define 30 days exactly including time 

if [$difference-gt$1]; then

hadoop fs -ls `echo$f| awk '{ print $8 }'`; # if the criteria meet then show the files 

fi

done
