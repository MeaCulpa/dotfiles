#!/bin/sh
#echo -e "auth admin XXXXXXXXX\ncs\nq\n" | nc localhost 4000
#watch -n5 'echo -e "auth admin XXXXXXXXX\ncs\nq\n" | nc localhost 4000'
watch -n5 'echo -e "auth admin XXXXXXXXX\ncs\nq\n" | nc localhost 4000 | grep -a Total'

