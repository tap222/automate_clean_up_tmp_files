#For real clusters it is not a good idea, to use ls. If you have admin rights, it is more suitable to use fsimage.
#To modify previous script into
#!/bin/bash
usage="Usage: dir_diff.sh [days]"

if [ ! "$1" ]
then
  echo $usage
  exit 1
fi

now=$(date +%s)
curl "http://localhost:50070/getimage?getimage=1&txid=latest" > img.dump
hdfs oiv -i img.dump -o fsimage.txt
cat fsimage.txt | grep "^d" | while read f; do 
  dir_date=`echo $f | awk '{print $6}'`
  difference=$(( ( $now - $(date -d "$dir_date" +%s) ) / (24 * 60 * 60 ) ))
  if [ $difference -gt $1 ]; then
    echo $f;
  fi
done



