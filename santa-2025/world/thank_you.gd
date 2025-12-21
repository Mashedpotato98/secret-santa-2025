extends Control


func _ready() -> void:
	$Button.grab_focus()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file('res://menus/main_menu.tscn')
