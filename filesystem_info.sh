#!/bin/ksh

####################################################
# Written By: Alejandro Perez Martin
# Purpose: Information about mounted filesystems
# Jan 22, 2014
####################################################

##### Variables #####
blocks=false
inode=false

##### Functions #####
error_msg() {
    echo "Info_Ocupa_Sist_Fich: Missing arguments"
    echo "Info_Ocupa_Sist_Fich: Syntax: 'Info_Ocupa_Sist_Fich -[OPTIONS]'"
    echo "Info_Ocupa_Sist_Fich: Run 'Info_Ocupa_Sist_Fich --help' for more options"
    exit 1
}

show_help() {
    printf "\nUsage: Info_Ocupa_Sist_Fich -[OPTIONS]

Displays information about mounted filesystems

Mandatory arguments to long options are mandatory for short options too.

  -h, --help     display this help and exit
  -i, --inodes   display information about filesystem's inodes
  -b, --bocks    display information about filesystem's blocks

Example of use:
    Info_Ocupa_Sist_Fich -b
    Info_Ocupa_Sist_Fich -i
    Info_Ocupa_Sist_Fich -bi"
    exit 0
}

# Error message
[[ $# -lt 1 ]] && error_msg

##### Options #####
while getopts "i(inodes)b(blocks)" option
do
    case $option in
        i)
            printf "##### INODES INFO #####\n"
            IFS=" "
            df -iP | tr -s "[:space:]" | tail -n +2 |
            while read fsystem inodes iused ifree iuse mntpoint
            do
                echo "Filesystem "\'$fsystem\'" has "$inodes" inodes ("$iused" used and "$ifree" free - "$iuse" used)"
            done
            echo "########################"
            ;;
        b)
            printf "##### BLOCKS INFO #####\n"
            IFS=" "
            df -P | tr -s "[:space:]" | tail -n +2 |
            while read fsystem blocks used available use mntpoint
            do
                echo "Filesystem "\'$fsystem\'" has "$blocks" blocks ("$used" used and "$available" free - "$use" used)"
            done
            echo "#######################"
            ;;
        *)  echo "Info_Ocupa_Sist_Fich: invalid option '-$OPTARG'"
            echo "Try 'Info_Ocupa_Sist_Fich --help' for more information."
            exit 1
    esac
done

exit 0
