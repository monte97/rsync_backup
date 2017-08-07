#! /bin/bash

day0=$(date '+%Y%m%d') 
day1=$(date --date='1 day ago' '+%Y%m%d' )
src=/root/src/ #the folder that has to be bcked
dst=/root/dst/$day0 #destination folder w/ today date
lnk=/root/dst/$day1 #incremental folder w/ yesterdate date
optInc='-avh --link-dest="$lnk"'
optFul='-avh'
if [ -d "$lnk" ]; 
then
	
	mkdir $dst 
	eval rsync $optInc $src $dst
else
	
	mkdir $dst 
	eval rsync $optFul $src $dst
fi


