#!/bin/bash

RED='\033[0;31m'

read -p 'Enter the name of that guy' comp
case $comp in
siva)
echo -e "\e[1;32m$comp is worst guy \e[0m"
;;
siddhu)
echo -e "\e[1;32m$comp is dobuleworst guy \e[0m"
;;
sekhar)
echo -e "\e[1;32m$comp is thop guy \e[0m"
;;
santhosh)
echo -e "\e[1;32m$comp is worst thop guy\e[0m"
;;
*)
echo -e "\e[1;31m please enter any of those 4S name \e[0m"
;;
esac

# while [$comp = sid] do
#    echo $comp is good
#    ;;
# while [$comp = sekhar] do
#    echo $comp is verygood
#    ;;
# while [$comp = siva] do
#    echo $comp is worst guy
#    ;;
# while [$comp = santhosh] do
#    echo $comp is thopguy
#    ;;
# while [$comp = *] do
#    echo $comp need 4S names only
#    ;;
# done