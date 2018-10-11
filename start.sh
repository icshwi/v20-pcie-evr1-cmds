#!/bin/bash
export IOC_EXEC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
export E3_BIN_DIR="/epics/base-3.15.5/require/3.0.0/bin"
export IOC_ST_CMD=st.labs-utgard-evr2.cmd
source "$E3_BIN_DIR/setE3Env.bash"
$E3_BIN_DIR/iocsh.bash $IOC_EXEC_DIR/$IOC_ST_CMD &
