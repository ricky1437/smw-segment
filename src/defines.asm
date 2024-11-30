include

; controller
!mario_byetudlr_hold = $0015
!mario_byetudlr_frame = $0016
!mario_axlr_hold = $0017
!mario_axlr_frame = $0018
!util_byetudlr_hold = $0DA2
!util_byetudlr_frame = $0DA6
!util_axlr_hold = $0DA4
!util_axlr_frame = $0DA8

; stripe image
!stripe_index    = $7F837B
!stripe_image    = $7F837D

; overworld
!submap_id = $13C3
!overworld_pos_x = $1F17
!overworld_pos_y = $1F19

; freeram
!freeram = $0695 ; cleared on reset and titlescreen load

; test
!test_gm0e = !freeram

; overworld warp
!warp_index = !freeram+1
