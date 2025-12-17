extends Control

@onready var wave_mode:String = ("res://world/main.tscn")
@onready var boss_mode:String = ("res://world/boss_room.tscn")
@onready var input_mode:CheckButton = $input_mode

func _ready():
    #input_mode.toggle_mode = Global._current_input()
    #input_mode.toggle_mode = true
    #print(Global._current_input())
    #print(Global.input_mode.find_key(Global.current_input))
    pass

func _on_exit_pressed() -> void:
    get_tree().quit()


func _on_boss_pressed() -> void:
    get_tree().change_scene_to_file(boss_mode)


func _on_wave_pressed() -> void:
    get_tree().change_scene_to_file(wave_mode)


func _on_input_mode_toggled(toggled_on: bool) -> void:
    if toggled_on:
        Global.current_input = Global.input_mode.CONTROLLER_MIX
    else :
        Global.current_input = Global.input_mode.KEYBOARD
    print(Global.input_mode.find_key(Global.current_input))
    #print(input_mode.toggle_mode)