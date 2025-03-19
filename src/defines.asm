include

; hardware regs
!hw_mul_l = $4216
!hw_mul_h = $4217

; stripe image
!stripe_index    = $7F837B
!stripe_image    = $7F837D

; controller
!mario_byetudlr_hold = $0015
!mario_byetudlr_frame = $0016
!mario_axlr_hold = $0017
!mario_axlr_frame = $0018
!util_byetudlr_hold = $0DA2
!util_byetudlr_frame = $0DA6
!util_axlr_hold = $0DA4
!util_axlr_frame = $0DA8

; player_status
!player_powerups = $0019
!player_powerups_buffer = $0DB8
!player_item_box = $0DC2
!player_item_box_buffer = $0DBC
!player_yoshi_flag = $0DC1
!player_yoshi_color = $13C7
!player_yoshi_color_buffer = $0DBA

; overworld
!overworld_submap = $1F11
!overworld_pos_x = $1F17
!overworld_pos_y = $1F19
!overworld_pos_pointer_x = $1F1F
!overworld_pos_pointer_y = $1F21

!switch_palace = $1f27

; savedata buffer
!buf_ow_tile_settings = $1f49

; overworld level setting flags
!is_special_beaten = $1EEB

; freeram
!freeram = $0695 ; cleared on reset and titlescreen load

; overworld warp
!menu_flag = !freeram+0
!warp_index = !freeram+1

; sram
!freesram = $700360

!isSramUsed = !freesram
!sram_powerups = !freesram+1
!sram_item_box = !freesram+2
!sram_yoshi_color = !freesram+3

!sram_warp_index = !freesram+4
