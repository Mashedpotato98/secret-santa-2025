extends Node2D

@export var animation_player:AnimationPlayer 
@export var dash_enemy:CharacterBody2D 
@export var small_guy:CharacterBody2D 
@export var big_guy:CharacterBody2D

@export var melee_part_enemies:Array[CharacterBody2D]  = []

enum STATES {
	teach_dash,
	teach_melee
}

var current_state:STATES = STATES.teach_dash


func _ready() -> void:
	await get_tree().create_timer(1.5).timeout
	small_guy.speed = 25
	get_tree().paused = true 
	animation_player.play('zoom_first_part')
	
func _process(delta: float) -> void:
	match current_state:
		STATES.teach_dash:
			teach_dash()

func teach_dash():
	if Input.is_action_just_pressed('dash'):
		get_tree().paused = false 

		animation_player.play_backwards('zoom_first_part')

		small_guy.regular_speed = 150
		dash_enemy.moving_speed = 20

		current_state = STATES.teach_melee

		_delete_entity(dash_enemy, 0.5)

func teach_melee():
	if melee_part_enemies.is_empty():
		print('done')

func _delete_entity(entity:CharacterBody2D,time:float):
	await get_tree().create_timer(time).timeout
	entity.queue_free()
		
