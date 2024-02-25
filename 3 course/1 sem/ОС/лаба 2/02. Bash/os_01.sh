if [ -z "$1" ]; then
echo "parameters not found"
exit
fi

if ! [[ $1 =~ ^[+-]?[0-9]+$ ]]; then
echo "$1 is not int"
exit

elif ps -p $1 > /dev/null
then
echo "Name: $0"
echo "pid: $1"
echo "ppid: `ps -o ppid= -p $1`"
if [ "$2" == "fd" ]; then
for variable in `ls -1 /proc/$1/fd`
do
echo fd $line = $variable
((line++))
done
fi

else
echo "pid $1 not found"
exit
fi