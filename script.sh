#! /bin/bash


#dst must contaion ONLY the backups, can be on a remote destination. see rsynk documentation
current_day=$(date '+%Y%m%d') 
src=/root/src/ #the folder that has to be bcked, contains the subfolder
dst_root=/root/dst
dst=$dst_root/$current_day #destination folder w/ today date 
last=$(ls $dst_root -Art | tail -n 1) 
lnk=$dst_root/$last
optInc='-avh --delete --link-dest="$lnk"'
optFul='-avh'

echo $lnk


percentage=$(df | grep 'md0' | awk 'BEGIN{} {percent+=$5;} END{print percent}')
while [ $percentage -gt 85 ]
do
	echo "rimozione"
	rm -r $(ls $dst_root -t -r | head -n 1)
	percentage=$(df | grep 'md0' | awk 'BEGIN{} {percent+=$5;} END{print percent}')
done 

touch output.log && echo "" > output.log
touch error.log && echo "" > error.log
if [ -d "$lnk"  ]; 
then
	mkdir $dst 
	eval rsync $optInc $src $dst > output.log 2> error.log ||  echo "" | mutt -s "rsync  error" -a output.log error.log -- backup @edilweb.net 
		
else				
	mkdir $dst 	
	eval rsync $optFul $src $dst > output.log 2> error.log || echo "" |  mutt -s "rsync  error" -a output.log error.log --  backup@edilweb.net 
fi

touch diskOccupation.txt && echo "" > diskOccupation.txt && df > diskOccupation.txt
cat diskOccupation.txt | mutt -s "Summary" -a diskOccupation.txt output.log -- backup@edilweb.net
