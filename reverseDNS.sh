#!/bin/bash
if [ "$1" == "" ]
then
	echo "REVERSE DNS SEARCH"
	echo "USE: $0 <site.com>"
else
	ip=$(host $1 | grep "has address" | cut -d " " -f 4)
	netblock=$(whois $ip | grep "inetnum")

	first=$(echo $netblock | cut -d ' ' -f 2 | rev | cut -c 1,2,3)
	first=$(echo $first | rev)

	last=$(echo $netblock | cut -d " " -f 4 | rev | cut -c 1,2,3)
	last=$(echo $last | rev)

	ip=$(echo $ip | sed 's/....$//')

	for endip in $(seq $first $last)
	do
		host -t ptr $ip.$endip
	done
fi
