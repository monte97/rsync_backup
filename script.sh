#! /bin/bash

day0=$(date '+%Y%m%d') 
day1=$(date --date='1 day ago' '+%Y%m%d' )
src=/root/src/
dst=/root/dst/$day0
lnk=/root/dst/$day1
optInc='-avh --link-dest="$lnk"'
optFul='-avh'
if [ -d "$lnk" ]; #la cartella della data di ieri esiste
then
	#se la folder esiste eseguo
	mkdir $dst #creo la folder di oggi
	eval rsync $optInc $src $dst
else
	#non esitono versioni precedenti
	mkdir $dst #creo la folder di oggi
	eval rsync $optFul $src $dst #eseguo completo
fi

#eval rsync $opt $src $dst

