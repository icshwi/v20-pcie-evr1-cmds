epicsEnvSet("SYS", "LabS-Utgard-VIP:TS")
epicsEnvSet("PCI_SLOT", "1:0.0")
epicsEnvSet("DEVICE", "EVR-2")
epicsEnvSet("EVR", "$(DEVICE)")
epicsEnvSet("CHIC_SYS", "Lab-Utgard-VIP:")
epicsEnvSet("CHOP_DRV", "Chop-CHIC-02")
epicsEnvSet("CHIC_DEV", "TS-$(DEVICE)")

epicsEnvSet("E3_MODULES", "/epics/modules/e3")
epicsEnvSet("EPICS_CMDS", "/epics/iocs/cmds")

< "$(EPICS_CMDS)/mrfioc2-common/st.evr.cmd"
