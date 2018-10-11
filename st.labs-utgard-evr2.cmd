epicsEnvSet("SYS", "LabS-Utgard-VIP:TS")
epicsEnvSet("PCI_SLOT", "1:0.0")
epicsEnvSet("DEVICE", "EVR-2")
epicsEnvSet("EVR", "$(DEVICE)")
epicsEnvSet("CHIC_SYS", "Lab-Utgard-VIP:")
epicsEnvSet("CHOP_DRV", "Chop-CHIC-")
epicsEnvSet("CHIC_DEV", "TS-$(DEVICE)")

# TODO: Work out a better way of identifying this path
< "/epics/iocs/cmds/mrfioc2-common/st.evr.cmd"
