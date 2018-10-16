epicsEnvSet("SYS", "LabS-Utgard-VIP:TS")
epicsEnvSet("PCI_SLOT", "1:0.0")
epicsEnvSet("DEVICE", "EVR-2")
epicsEnvSet("EVR", "$(DEVICE)")
epicsEnvSet("CHIC_SYS", "LabS-Utgard-VIP:")
epicsEnvSet("CHOP_DRV", "Chop-Drv-02")
epicsEnvSet("CHIC_DEV", "TS-$(DEVICE)")

epicsEnvSet("E3_MODULES", "/epics/iocs/e3")
epicsEnvSet("EPICS_CMDS", "/epics/iocs/cmds")

< "$(EPICS_CMDS)/mrfioc2-common/st.evr.cmd"
