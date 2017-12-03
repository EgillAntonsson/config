#!/bin/bash

# remap numeric keypad numbers to have top row as "1 2 3" and bottom row "7 8 9"
xmodmap -e "keycode 87 = KP_7"
xmodmap -e "keycode 88 = KP_8"
xmodmap -e "keycode 89 = KP_9"
xmodmap -e "keycode 79 = KP_1"
xmodmap -e "keycode 80 = KP_2"
xmodmap -e "keycode 81 = KP_3"

# make startup run this change
xmodmap -pke >~/.Xmodmap
echo "xmodmap .Xmodmap in." >~/.xinitrc

# 87 KP_1
# 88 KP_2
# 89 KP_3
# 83 KP_4
# 84 KP_5
# 85 KP_6
# 79 KP_7
# 80 KP_8
# 81 KP_9
# 90 KP_0