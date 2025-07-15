# Number of times to collect data.
LOOP=6
# Interval in seconds between data points.
INTERVAL=20

for ((i=1; i <= $LOOP; i++))
do
   _now=$(date)
   echo "${_now}" >>high-cpu.out
   top -b -n 1 -H -p $1 >>high-cpu.out
   echo "${_now}" >>high-cpu-tdump.out
   jstack -l $1 >>high-cpu-tdump.out
   echo "thread dump #" $i
   if [ $i -lt $LOOP ]; then
      echo "Sleeping..."
      sleep $INTERVAL
   fi
done

