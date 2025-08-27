create_pblock pblock_2
add_cells_to_pblock [get_pblocks pblock_2] [get_cells -quiet [list Stadio_1]]
resize_pblock [get_pblocks pblock_2] -add {SLICE_X12Y125:SLICE_X15Y127}
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_2]

create_pblock pblock_1
add_cells_to_pblock [get_pblocks pblock_1] [get_cells -quiet [list *.Stadio_2]]
resize_pblock [get_pblocks pblock_1] -add {SLICE_X20Y125:SLICE_X23Y127}
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_1]

create_pblock pblock_3
add_cells_to_pblock [get_pblocks pblock_3] [get_cells -quiet [list Stadio_3]]
resize_pblock [get_pblocks pblock_3] -add {SLICE_X28Y125:SLICE_X31Y127}
set_property EXCLUDE_PLACEMENT 1 [get_pblocks pblock_3]

