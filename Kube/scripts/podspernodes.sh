kubectl -n farm-services get pods -o wide | grep browsers | grep -v -i Completed | awk '{ print $7 }' | sort | uniq -c
