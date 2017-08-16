#! /bin/bash


#dst must contaion ONLY the backups, can be on a remote destination. see rsynk documentation
current_day=$(date '+%Y%m%d') 
src=/root/src/ #the folder that has to be bcked
dst_root=/root/dst #the destination folder root
dst=$dst_root/current_day #destination folder w/ today date 
lnk=/root/dst/$(ls $dst_root -Art | tail -n 1) #we synk w/ the most recent folder
optInc='-avh --delete --link-dest="$lnk"'
optFul='-avh'
limit=85

#chande sda w/ the device wich contains the backup folder
percentage=$(df | grep 'sda' | awk 'BEGIN{} {percent+=$5;} END{print percent}')
while [ $percentage -gt 85 ]
do
	rm -r $(ls $dst_root -t -r | head -n 1)
	percentage=$(df | grep 'sda' | awk 'BEGIN{} {percent+=$5;} END{print percent}')
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


