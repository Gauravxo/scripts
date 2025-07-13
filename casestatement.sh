#!/bin/bash
action=${1,,}
# start,stop,restart,reload
case ${action} in
    start)
        echo "going to start"
        echo "actionone two"
        ;;
    stop)
        echo "going to stop"
        ;;
    reload)
        echo "going to reload"
        ;;
    restart)
        echo "going to restart"
        ;;
    *)
        echo "please enter correct command line args."
esac  
