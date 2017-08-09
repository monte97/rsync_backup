#! /bin/bash


#dst must contaion ONLY the backups, can be on a remote destination. see rsynk documentation
day0=$(date '+%Y%m%d') 
src=/root/src/ #the folder that has to be bcked
dst_root=/root/dst #the destination folder root
dst=$dst_root/$day0 #destination folder w/ today date
last=$(ls $dst_root -Art | tail -n 1) 
lnk=/root/dst/$last #we synk w/ the most recent folder
optInc='-avh --link-dest="$lnk"'
optFul='-avh'


#while we are above the occupation threshoold we keep deleting the oldest folder in the backup root
disksize=$(du -sk $dst_root |cut -f1)
disk=$(df -k $dir | nawk '!Filesystem/ print{$2})')
percentage=eval($disksize/$disk)
limit=85

while [ $percentage -gt $limit]
do
	rm -r $(ls $dst_root -t -r | head -n 1)
done 

if [ -n "$last"  ]; 
then
	#full backup
	mkdir $dst 
	eval rsync $optInc $src $dst
else
	
	#incremental backup
	mkdir $dst 
	eval rsync $optFul $src $dst
fi


