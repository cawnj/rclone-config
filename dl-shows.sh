#!/bin/bash

file=links.txt
until [[ -z $(grep '[^[:space:]]' $file) ]]
do
	if (( $(df | grep /dev/ploop | awk '{sub (/%/, "", $5); print $5 }') < 80 ))
	then
		proxychains4 python3 /home/plexuser/rd-dl/rd-dl.py $file
		echo
		echo "RESTARTING..."
		echo
	else
		echo
		echo "STORAGE FULL, ORGANISING AND UPLOADING"
		echo
		cd download
		plex-organise
		plex-upload
		cd ..
	fi
done

echo
echo "FINISHED DOWNLOADING, ORGANISING AND UPLOADING"
echo
cd download
plex-organise
plex-upload

echo
echo "COMPLETE"
echo
