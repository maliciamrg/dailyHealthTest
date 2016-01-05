#!/bin/sh
logger_cmd="logger -p local6.debug -t $0[$$]"
$logger_cmd "$(whoami)"
if [ -f ./tweet_sysout.txt ]; then
	rm ./tweet_sysout.txt
fi
sleep 2

test()
{
if (echo $(/etc/init.d/$1 status | grep Active ) | grep -q "(running)"); then 
	#echo "$1 running \n"; 
    echo ""; 
else 
	echo "$1 not running"; 
fi
}

test2()
{
if (echo $(/etc/init.d/$1 status | grep EyeFiServer ) | grep -q "EyeFiServer is running"); then 
	#echo "$1 running \n"; 
    echo ""; 
else 
	echo "$1 not running"; 
fi
}

test3()
{
if (echo $(/etc/init.d/$1 status | grep $1 ) | grep -q "david: running"); then 
	#echo "$1 running \n"; 
    echo ""; 
else 
	echo "$1 not running"; 
fi
}

res=":"
res="$res $(test "apache2" ) ."
res="$res $(test2 "eyefiserver" ) ."
res="$res $(test3 "dropbox" ) ."
res="$res $(test "mysql" ) ."
res="$res $(test "sickrage" ) ."
res="$res $(test "transmission-daemon" ) ."
echo $res > ./tweet_sysout.txt 
if (echo $res | grep -q "not running"); then 
	tweet $0 $res
	$logger_cmd "$res";
fi





