require mrfioc2,2.2.0-rc2
#require pev,0.1.2

epicsEnvSet(        "SYS", "LabS-Utgard-VIP:")
epicsEnvSet(        "EVG",        "TS-EVG-1:")
# epicsEnvSet("EVG_VMESLOT",            "3")

#mrmEvgSetupVME($(EVG), $(EVG_VMESLOT), 0x100000, 1, 0x01)


# ESS ICS Definition
epicsEnvSet("HWEVT"    "14")
epicsEnvSet("EVTFREQ"  "14")

# Fake Timestamp
# epicsEnvSet("EVRTSE"   "-2")

# Don't change HBEVT
epicsEnvSet("HBEVT"   "122")
# One can change, but don't change it.
epicsEnvSet("HBFREQ"    "1")

# --------------------------------------------------------
# Set Heart Beat Event (Evtcode, Fre, TrigSrc7) (122, 1, 1)
# Set 14 Hz      Event (Evtcode, Fre, TrigSrc0) (14, 14, 1)
#
dbLoadRecords("evg-vme-230.db", "DEVICE=$(EVG), SYS=$(SYS), EvtClk-FracSynFreq-SP=88.0519, TrigEvt7-EvtCode-SP=$(HBEVT), Mxc2-Frequency-SP=$(HBFREQ), Mxc2-TrigSrc7-SP=1, TrigEvt0-EvtCode-SP=$(HWEVT), Mxc0-Frequency-SP=$(EVTFREQ), Mxc0-TrigSrc0-SP=1, SoftEvt-Enable-Sel=1")

iocInit

# Fake timestamp source for testing without real hardware timestamp source (e.g., GPS recevier)
mrmEvgSoftTime($(EVG))

sleep(10)

# Mandatory if Fake timestamp source for testing without real hardware timestamp source (e.g., GPS recevier)
#
dbpf $(SYS)-$(EVG):SyncTimestamp-Cmd 1
