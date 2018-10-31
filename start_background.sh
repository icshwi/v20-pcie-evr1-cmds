#!/bin/bash
export IOC_EXEC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
export VAR_DIR="/var"
export E3_BIN_DIR="/epics/base-3.15.5/require/3.0.2/bin"
export PROCSERV="/usr/bin/procServ"
export PROCSERV_PORT=2000
export PROCSERV_IOC_DIR=labs-utgard-evr2
export IOC_ST_CMD=st.labs-utgard-evr2.cmd
source "$E3_BIN_DIR/setE3Env.bash"
$PROCSERV -f -L $VAR_DIR/log/procServ/$PROCSERV_IOC_DIR -i ^C^D -c $VAR_DIR/run/procServ/$PROCSERV_IOC_DIR $PROCSERV_PORT $E3_BIN_DIR/iocsh.bash $IOC_EXEC_DIR/$IOC_ST_CMD &
