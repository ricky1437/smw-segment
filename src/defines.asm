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
!overworld_submap = $1F11
!overworld_pos_x = $1F17
!overworld_pos_y = $1F19
!overworld_pos_pointer_x = $1F1F
!overworld_pos_pointer_y = $1F21

; freeram
!freeram = $0695 ; cleared on reset and titlescreen load

; overworld warp
!menu_flag = !freeram+0
!warp_index = !freeram+1
