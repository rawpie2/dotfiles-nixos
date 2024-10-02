#!/bin/bash

INTERNAL_KEYBOARD_ID=$(xinput list | grep "AT Translated Set 2 keyboard" | grep -o 'id=[0-9]*' | cut -d= -f2)

disable_internal_keyboard() {
    xinput float $INTERNAL_KEYBOARD_ID
}

enable_internal_keyboard() {
    xinput reattach $INTERNAL_KEYBOARD_ID 3
}

if xinput list | grep -q "USB keyboard"; then
    disable_internal_keyboard
else
    enable_internal_keyboard
fi
