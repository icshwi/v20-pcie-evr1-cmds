# This the full setup for the Timing System with E3.
#

require mrfioc2, 2.2.0-rc2
require iocStats, ae5d083
require autosave, 5.9.0

epicsEnvSet("ENGINEER","Nicklas Holmberg")
epicsEnvSet("LOCATION","Utgard")

epicsEnvSet("IOC", "LabS-Utgard-VIP:TS")
epicsEnvSet("DEV1", "EVG-1")

epicsEnvSet("MainEvtCODE" "14")
epicsEnvSet("HeartBeatEvtCODE"   "122")
epicsEnvSet("ESSEvtClockRate"  "88.0525")

mrmEvgSetupPCI($(DEV1), "6:0d.0")
dbLoadRecords("evg-cpci-230-ess.db",  "SYS=$(IOC), D=$(DEV1), EVG=$(DEV1), FEVT=$(ESSEvtClockRate), FRF=$(ESSEvtClockRate), FDIV=1, PINITSEQ=0")

# iocStats
dbLoadRecords("iocAdminSoft.db", "IOC=$(IOC)-$(DEV1)-IocStats")


# Auto save/restore

# Directory should be existent before IOC runing
#epicsEnvSet("AUTOSAVE", "/home/timinguser/autosave")
epicsEnvSet("AUTOSAVE_ROOT", "/epics/iocs/autosave")
epicsEnvSet("AUTOSAVE", "$(AUTOSAVE_ROOT)/$(IOC)-$(DEV1)")

#var save_restoreDebug 1

dbLoadRecords("save_restoreStatus.db", "P=$(IOC):Autosave")
save_restoreSet_status_prefix("$(IOC)-$(DEV1):Autosave")
system("mkdir -p -m 0755 $(AUTOSAVE)")
set_savefile_path("$(AUTOSAVE)")
set_requestfile_path("$(AUTOSAVE)")
set_pass0_restoreFile("mrf_settings.sav")
set_pass0_restoreFile("mrf_values.sav")
set_pass1_restoreFile("mrf_values.sav")
set_pass1_restoreFile("mrf_waveforms.sav")


iocInit()


#dbl > "${IOC}_PVs.list"


makeAutosaveFileFromDbInfo("$(AUTOSAVE)/mrf_settings.req",  "autosaveFields_pass0")
makeAutosaveFileFromDbInfo("$(AUTOSAVE)/mrf_values.req",    "autosaveFields")
makeAutosaveFileFromDbInfo("$(AUTOSAVE)/mrf_waveforms.req", "autosaveFields_pass1")

create_monitor_set("mrf_settings.req",   5 , "")
create_monitor_set("mrf_values.req",     5 , "")
create_monitor_set("mrf_waveforms.req", 30 , "")


############### Configure RF input ##########
#dbpf $(IOC)-$(DEV1):EvtClk-Source-Sel "RF"
#dbpf $(IOC)-$(DEV1):EvtClk-RFFreq-SP 88.0525
#dbpf $(IOC)-$(DEV1):EvtClk-RFDiv-SP 1
############### Configure RF input ##########

dbpf "$(IOC)-$(DEV1):1ppsInp-Sel" "Sys Clk"
############## Configure front panel for evr 125 1 Hz ##############
#dbpf $(IOC)-$(DEV1):TrigEvt1-EvtCode-SP 125
#dbpf $(IOC)-$(DEV1):TrigEvt1-TrigSrc-Sel "Univ0"
#dbpf $(IOC)-$(DEV1):1ppsInp-Sel "Univ0"
#dbpf $(IOC)-$(DEV1):1ppsInp-MbbiDir_.TPRO 1
############## Configure front panel for evr 125 1 Hz ##############

############## Master Event Rate 14 Hz ##############
dbpf $(IOC)-$(DEV1):Mxc0-Prescaler-SP 6289464
#dbpf $(IOC)-$(DEV1):TrigEvt0-EvtCode-SP $(MainEvtCODE)
#dbpf $(IOC)-$(DEV1):TrigEvt0-TrigSrc-Sel "Mxc0"
# Setup of sequencer
dbpf $(IOC)-$(DEV1):SoftSeq0-RunMode-Sel "Normal"
dbpf $(IOC)-$(DEV1):SoftSeq0-TrigSrc-Sel "Mxc0"
dbpf $(IOC)-$(DEV1):SoftSeq0-TsResolution-Sel "uSec"
dbpf $(IOC)-$(DEV1):SoftSeq0-Load-Cmd 1
dbpf $(IOC)-$(DEV1):SoftSeq0-Enable-Cmd 1
# Load the sequence
system("/bin/sh ./configure_sequencer_14Hz.sh $(IOC) $(DEV1)")
############## Master Event Rate 14 Hz ##############

# # Heart Beat 1 Hz
dbpf $(IOC)-$(DEV1):Mxc7-Prescaler-SP 88052500
dbpf $(IOC)-$(DEV1):TrigEvt7-EvtCode-SP $(HeartBeatEvtCODE)
dbpf $(IOC)-$(DEV1):TrigEvt7-TrigSrc-Sel "Mxc7"

epicsThreadSleep 5
dbpf $(IOC)-$(DEV1):SyncTimestamp-Cmd 1


