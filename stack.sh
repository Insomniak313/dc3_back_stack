#!/bin/bash

## CONFIGURATION ###################################

STACK_NAME="myproject"

####################################################


## RUN #############################################

case $1 in

    start)
        docker-compose -f docker-compose.yml -p $STACK_NAME up -d
    ;;

    stop)
        docker-compose -p $STACK_NAME stop
    ;;

    build)
        docker-compose -f docker-compose.yml -p $STACK_NAME build
    ;;

    rebuild)
        docker-compose -p $STACK_NAME stop
        docker-compose -f docker-compose.yml -p $STACK_NAME build
        docker-compose -f docker-compose.yml -p $STACK_NAME up -d
    ;;

    cli)
        case $2 in
          php)
              if [ "$3" = "root" ]
              then
                  docker exec -ti -u root --env COLUMNS=`tput cols` --env LINES=`tput lines` $STACK_NAME\_$2_1 bash
              else
                  docker exec -ti -u www-data --env COLUMNS=`tput cols` --env LINES=`tput lines` $STACK_NAME\_$2_1 bash
              fi
              exit 0
              ;;
        esac

        docker exec -ti --env COLUMNS=`tput cols` --env LINES=`tput lines` $STACK_NAME\_$2_1 bash
    ;;

    *)
        echo -e "Error: unknown argument"
        echo -e "Usage: ./stack.sh start|stop|build|rebuild|cli"

esac


## DEFAULT ACTION ##################################

exit 127 # "Command not found" exit code

####################################################
