extends Control

@onready var wave_mode:String = ("res://world/main.tscn")
@onready var boss_mode:String = ("res://world/boss_room.tscn")

@onready var input_mode:CheckButton = $BoxContainer/MainButton/input_mode
@onready var settings_menu:VBoxContainer = $BoxContainer/settings
@onready var main_menu:VBoxContainer = $BoxContainer/MainButton
@onready var fullscreen_toggle:CheckBox = $BoxContainer/settings/fullscreen
@onready var wave_button:Button = $BoxContainer/MainButton/Boss #only being used to grab focus
@onready var main_volume_slider:HSlider = $BoxContainer/settings/vol_slider_main
@onready var sfx_volume_slider:HSlider = $BoxContainer/settings/vol_slider_sfx
@onready var music_volume_slider:HSlider = $BoxContainer/settings/vol_slider_music

@onready var volume_sliders:Array[HSlider] = [main_volume_slider, sfx_volume_slider, music_volume_slider]

const slider_step_controller:float = 0.1
const slider_step_keyboard:float = 0.001

var volume_groups = {
	'vol_slider_main': 'Master',
	'vol_slider_sfx' : 'SFX',
	'vol_slider_music' : 'music'
}

func _ready():
	_disable_settings()

	#checks input mode and adjusts accordingly
	if Global.current_input == Global.input_mode.CONTROLLER_MIX:
		input_mode.button_pressed = true
		_slider_step_adjust(slider_step_controller)
	#else :
		input_mode.button_pressed = false
		_slider_step_adjust(slider_step_keyboard)

	#checks display mode and adjusts accordingly
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		fullscreen_toggle.button_pressed = true
	else :
		fullscreen_toggle.button_pressed = false
	
	for slider:HSlider in volume_sliders:
		print(volume_groups[slider.name])
		slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index(volume_groups[slider.name])))
	
	
		 
func _enable_settings():
	fullscreen_toggle.grab_focus()
	main_menu.visible = false
	settings_menu.visible = true

func _disable_settings():
	wave_button.grab_focus()
	settings_menu.visible = false
	main_menu.visible = true

func _slider_step_adjust(adjusted_to:float):
	for slider:HSlider in volume_sliders:
		slider.step = adjusted_to



func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_boss_pressed() -> void:
	get_tree().change_scene_to_file(boss_mode)


func _on_wave_pressed() -> void:
	get_tree().change_scene_to_file(wave_mode)


func _on_input_mode_toggled(toggled_on: bool) -> void:
	if toggled_on:
		Global.current_input = Global.input_mode.CONTROLLER_MIX
		_slider_step_adjust(slider_step_controller)
	else :
		Global.current_input = Global.input_mode.KEYBOARD
		_slider_step_adjust(slider_step_keyboard) 


func _on_settings_pressed() -> void:
	_enable_settings() 

func _on_settings_back_pressed() -> void:
	_disable_settings()



func _on_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on: 
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else :
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		
func _on_vol_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index('Master'), value)

func _on_vol_slider_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index('SFX'), value)

func _on_vol_slider_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index('music'), value)
