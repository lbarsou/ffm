#! /bin/bash
rm /tmp/ffmOutput /tmp/ffmOutput1

declare -A colorApp=( [code]=202m [firefox]=202m [spotify]=40m [chrome]=226m [jupyter]=248m [kitty]=124m [nemo]=94m [terminal]=240m [mousepad]=45m [discord]=133m [python]=21m )

function getMem		{
memApp=$(ps aux | awk '/'$1'/ {sum += $6} END { printf "%d\n"ps, sum/1024 }')
(("$memApp"  > "3" )) && memUsed=$(free -m | grep Mem | awk 'END {print $3}') memAppT=$(($memApp*100/7869)) memAppU=$(($memApp*100/$memUsed)) && echo -e "\e[1;38;5;${colorApp[$1]}${1^^}\e[0m" $memApp"MB" $memAppT"%" $memAppU"%"  >> /tmp/ffmOutput
}

for key in "${!colorApp[@]}"
do
	getMem $key
done 

echo -e "\e[1;4;97m Total Used Free\e[0m" >> /tmp/ffmOutput1
free -m | grep Mem | awk 'END { print "Mem: "$2"MB "$3"MB "$7"MB\nPerc.: 100% "$3*100/$2"% "$7*100/$2"%" }' >> /tmp/ffmOutput1

echo -e "\e[1;4;97mAPP RSS T% U%\e[0m" >> /tmp/ffmOutput1
sort -k 2nr /tmp/ffmOutput >> /tmp/ffmOutput1

cat /tmp/ffmOutput1 | column -t -R 2,3,4 
