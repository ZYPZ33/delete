#!/usr/bin/env sh
if [ -n "$1" ]; then executable_name=$1; else executable_name='delete'
if [ -n "$2" ]; then install_directory=$2; else install_directory='/usr/local/bin'

install delete.sh ${install_directory}/${executable_name}
