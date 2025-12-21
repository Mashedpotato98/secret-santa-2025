extends Control

@onready var main_menu:String = "res://menus/main_menu.tscn"

func _ready() -> void:
	$Button.grab_focus()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu)
