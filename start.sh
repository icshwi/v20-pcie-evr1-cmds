#!/bin/bash
#export VIP_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
#source "$VIP_SCRIPT_DIR/../../env.sh"
#source "$VIP_SCRIPT_DIR/env.sh"
#modprobe uio
#modprobe parport
#insmod $VIP_SCRIPT_DIR/mrf.ko
#iocsh.bash "$VIP_SCRIPT_DIR/st.utgard-cpci-evg1.cmd" 
iocsh.bash "st.utgard-cpci-evg1.cmd" 
