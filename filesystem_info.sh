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
    echo "filesystem_info: Missing arguments"
    echo "filesystem_info: Syntax: 'filesystem_info -[OPTIONS]'"
    echo "filesystem_info: Run 'filesystem_info --help' for more options"
    exit 1
}

show_help() {
    printf "\nUsage: filesystem_info -[OPTIONS]

Displays information about mounted filesystems

Mandatory arguments to long options are mandatory for short options too.

  -h, --help     display this help and exit
  -i, --inodes   display information about filesystem's inodes
  -b, --bocks    display information about filesystem's blocks

Example of use:
    filesystem_info -b
    filesystem_info -i
    filesystem_info -bi"
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
        *)  echo "filesystem_info: invalid option '-$OPTARG'"
            echo "Try 'filesystem_info --help' for more information."
            exit 1
    esac
done

exit 0
