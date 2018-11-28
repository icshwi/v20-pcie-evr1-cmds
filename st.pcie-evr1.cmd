epicsEnvSet("SYS", "LabS-Utgard-VIP:TS")
epicsEnvSet("PCI_SLOT", "1:0.0")
epicsEnvSet("DEVICE", "EVR-2")
epicsEnvSet("EVR", "$(DEVICE)")
epicsEnvSet("CHIC_SYS", "LabS-Utgard-VIP:")
epicsEnvSet("CHOP_DRV", "Chop-Drv-02")
epicsEnvSet("CHIC_DEV", "TS-$(DEVICE)")

epicsEnvSet("E3_MODULES", "/epics/iocs/e3")
epicsEnvSet("EPICS_CMDS", "/epics/iocs/cmds")

######## Temporary until chopper group ###########
######## changes PV names              ###########
epicsEnvSet("NCG_SYS", "LabS-VIP:")
epicsEnvSet("NCG_DRV", "Chop-Drv-01:")
##################################################

< "$(EPICS_CMDS)/mrfioc2-common/st.evr.cmd"

# Set delay compensation target. This is required even when delay compensation
# is disabled to avoid occasionally corrupting timestamps.
#dbpf $(SYS)-$(DEVICE):DC-Tgt-SP 70
dbpf $(SYS)-$(DEVICE):DC-Tgt-SP 100

######### INPUTS #########

# Set up of UnivIO 0 as Input. Generate Code 10 locally on rising edge.
dbpf $(SYS)-$(DEVICE):In0-Lvl-Sel "Active High"
dbpf $(SYS)-$(DEVICE):In0-Edge-Sel "Active Rising"
dbpf $(SYS)-$(DEVICE):OutFPUV00-Src-SP 61
dbpf $(SYS)-$(DEVICE):In0-Trig-Ext-Sel "Edge"
dbpf $(SYS)-$(DEVICE):In0-Code-Ext-SP 10
dbpf $(SYS)-$(DEVICE):EvtA-SP.OUT "@OBJ=$(EVR),Code=10"
dbpf $(SYS)-$(DEVICE):EvtA-SP.VAL 10

# Set up of UnivIO 1 as Input. Generate Code 11 locally on rising edge.
dbpf $(SYS)-$(DEVICE):In1-Lvl-Sel "Active High"
dbpf $(SYS)-$(DEVICE):In1-Edge-Sel "Active Rising"
dbpf $(SYS)-$(DEVICE):OutFPUV01-Src-SP 61
dbpf $(SYS)-$(DEVICE):In1-Trig-Ext-Sel "Edge"
dbpf $(SYS)-$(DEVICE):In1-Code-Ext-SP 11
dbpf $(SYS)-$(DEVICE):EvtB-SP.OUT "@OBJ=$(EVR),Code=11"
dbpf $(SYS)-$(DEVICE):EvtB-SP.VAL 11

######### OUTPUTS #########
#Set up delay generator 0 to trigger on event 14
dbpf $(SYS)-$(DEVICE):DlyGen0-Width-SP 1000 #1ms
dbpf $(SYS)-$(DEVICE):DlyGen0-Delay-SP 0 #0ms
dbpf $(SYS)-$(DEVICE):DlyGen0-Evt-Trig0-SP 14

#Set up delay generator 1 to trigger on event 14
dbpf $(SYS)-$(DEVICE):DlyGen1-Evt-Trig0-SP 14
dbpf $(SYS)-$(DEVICE):DlyGen1-Width-SP 2860 #1ms
dbpf $(SYS)-$(DEVICE):DlyGen1-Delay-SP 0 #0ms

#Set up delay generator 2 to trigger on event 17
dbpf $(SYS)-$(DEVICE):DlyGen2-Width-SP 1000 #1ms
dbpf $(SYS)-$(DEVICE):DlyGen2-Delay-SP 0 #0ms
dbpf $(SYS)-$(DEVICE):DlyGen2-Evt-Trig0-SP 17
dbpf $(SYS)-$(DEVICE):OutFPUV02-Src-SP 2 #Connect output2 to DlyGen-2

#Set up delay generator 3 to trigger on event 18
dbpf $(SYS)-$(DEVICE):DlyGen3-Width-SP 1000 #1ms
dbpf $(SYS)-$(DEVICE):DlyGen3-Delay-SP 0 #0ms
dbpf $(SYS)-$(DEVICE):DlyGen3-Evt-Trig0-SP 18
dbpf $(SYS)-$(DEVICE):OutFPUV03-Src-SP 3 #Connect output3 to DlyGen-3

######## Sequencer #########
# Load sequencer setup
dbpf $(SYS)-$(DEVICE):SoftSeq0-Load-Cmd 1

# Enable sequencer
dbpf $(SYS)-$(DEVICE):SoftSeq0-Enable-Cmd 1

# Select run mode, "Single" needs a new Enable-Cmd every time, "Normal" needs Enable-Cmd once
dbpf $(SYS)-$(DEVICE):SoftSeq0-RunMode-Sel "Normal"

# Select trigger source for soft seq 0, trigger source 0, delay gen 0
dbpf $(SYS)-$(DEVICE):SoftSeq0-TrigSrc-0-Sel 0

dbpf $(CHIC_SYS)$(CHOP_DRV)01:Freq-SP 28
dbpf $(CHIC_SYS)$(CHOP_DRV)01:Tube-Pos-Delay 10
dbpf $(CHIC_SYS)$(CHOP_DRV)02:Freq-SP 28
dbpf $(CHIC_SYS)$(CHOP_DRV)02:Tube-Pos-Delay 20
# Check that this command is required.
#dbpf $(SYS)-$(DEVICE):RF-Freq 88052500

# Hints for setting input PVs from client
#caput -a $(SYS)-$(DEVICE):SoftSeq0-EvtCode-SP 2 17 18
#caput -a $(SYS)-$(DEVICE):SoftSeq0-Timestamp-SP 2 0 12578845
#caput -n $(SYS)-$(DEVICE):SoftSeq0-Commit-Cmd 1
######### TIME STAMP #########

#Forward links to esschicTimestampBuffer.template
#dbpf $(SYS)-$(DEVICE):EvtACnt-I.FLNK $(CHIC_SYS)$(CHOP_DRV):TDC
#dbpf $(SYS)-$(DEVICE):EvtECnt-I.FLNK $(CHIC_SYS)$(CHOP_DRV):Ref

#dbpf $(SYS)-$(DEVICE):EvtBCnt-I.FLNK $(CHIC_SYS)$(CHOP_DRV):TDC
#dbpf $(CHIC_SYS)$(CHOP_DRV)01:BPFO.LNK3 $(CHIC_SYS)$(CHOP_DRV):Ref

