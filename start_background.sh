#!/bin/bash
export IOC_EXEC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
#source "$VIP_SCRIPT_DIR/../../env.sh"
export VAR_DIR="/var"
export E3_BIN_DIR="/epics/base-3.15.5/require/3.0.0/bin"
export PROCSERV="/bin/procServ"
export PROCSERV_PORT=2000
export PROCSERV_IOC_DIR=labs-utgard-evg1
export IOC_ST_CMD=st.labs-utgard-evg1.cmd
#modprobe uio
#modprobe parport
#insmod $VIP_SCRIPT_DIR/mrf.ko
#nohup iocsh.bash "$VIP_SCRIPT_DIR/st.cmd" < /dev/zero &
source "$E3_BIN_DIR/setE3Env.bash"
$PROCSERV -f -L $VAR_DIR/log/procServ/$PROCSERV_IOC_DIR -i ^C^D -c $VAR_DIR/run/procServ/$PROCSERV_IOC_DIR $PROCSERV_PORT $E3_BIN_DIR/iocsh.bash $IOC_EXEC_DIR/$IOC_ST_CMD &
