while read i
do
    echo ${i} | awk '{ print $1 }'
    HOST=$(echo ${i} | awk '{ print $1 }' )
done < /tmp/hostlist.txt
