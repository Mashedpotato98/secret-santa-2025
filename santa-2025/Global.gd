extends Node

enum input_mode {
    CONTROLLER_MIX,
    KEYBOARD
}

var wave_score:int = 0

var current_input:input_mode = input_mode.CONTROLLER_MIX

func _ready() -> void:
    print(current_input)

func _current_input():
    if current_input == input_mode.CONTROLLER_MIX:
        return true
    else :
        return false
