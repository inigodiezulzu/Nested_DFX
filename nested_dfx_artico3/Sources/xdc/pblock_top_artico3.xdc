create_pblock pblock_inst_RP
add_cells_to_pblock [get_pblocks pblock_inst_RP] [get_cells -quiet [list inst_RP]]
resize_pblock [get_pblocks pblock_inst_RP] -add {SLICE_X0Y180:SLICE_X96Y419 DSP48E2_X0Y72:DSP48E2_X17Y167 IOB_X0Y156:IOB_X1Y279 RAMB18_X0Y72:RAMB18_X12Y167 RAMB36_X0Y36:RAMB36_X12Y83}
resize_pblock [get_pblocks pblock_inst_RP] -add {SLICE_X35Y0:SLICE_X55Y180 BUFG_PS_X0Y0:BUFG_PS_X0Y71 DSP48E2_X7Y0:DSP48E2_X11Y71 RAMB18_X5Y0:RAMB18_X6Y71 RAMB36_X5Y0:RAMB36_X6Y35}
set_property SNAPPING_MODE ON [get_pblocks pblock_inst_RP]
set_property IS_SOFT FALSE [get_pblocks pblock_inst_RP]