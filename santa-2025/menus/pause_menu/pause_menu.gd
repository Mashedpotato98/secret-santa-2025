extends Control

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var main_menu:String = 'res://menus/main_menu.tscn'
@onready var resume_button:Button = $BoxContainer/VBoxContainer/Resume
@onready var player_continue:Label = $BoxContainer/VBoxContainer/player

func _ready():
    resume()
    animation_player.play("RESET")


func resume():
    get_tree().paused = false
    animation_player.play_backwards("blur")

func pause():
    get_tree().paused = true
    animation_player.play("blur")
    resume_button.grab_focus()

func testEsc(event:InputEvent):
    if event.is_action_pressed('ui_cancel') and !get_tree().paused:
        pause()
    elif event.is_action_pressed('ui_cancel') and get_tree().paused:
        resume()
        
func _input(event: InputEvent) -> void:
    testEsc(event)

func _on_resume_pressed() -> void:
    resume()

func _on_exit_game_pressed() -> void:
    get_tree().quit()

func _on_main_menu_pressed() -> void:
    get_tree().change_scene_to_file(main_menu)

func _on_restart_pressed() -> void:
    get_tree().reload_current_scene()
