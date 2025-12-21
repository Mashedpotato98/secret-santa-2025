class_name shieldEnemy extends CharacterBody2D

signal died(_type:CharacterBody2D)

@onready var animation_player:AnimationPlayer = $AnimationPlayer

@onready var big_guy:CharacterBody2D = get_tree().get_first_node_in_group("big_guy")
@onready var small_guy:CharacterBody2D = get_tree().get_first_node_in_group("small_guy")
@onready var players:Array[CharacterBody2D] = [big_guy, small_guy] 
@onready var knockback_receiver:Node2D = $knockback_receiver

@onready var shield_hit_audio:AudioStreamPlayer2D = $audio/hit_shield

@export var regular_speed:int = 20
@export var defence_speed:int = 10
@onready var speed:int = regular_speed

var direction:Vector2 
var knockback:Vector2
var is_dead:bool = false

func _physics_process(delta: float) -> void:
	velocity = direction * speed + knockback 
	knockback = lerp(knockback, Vector2.ZERO, 0.1) 
	
	move_and_slide()

func _look_at(pos:Vector2):
	rotation = lerp_angle(rotation, global_position.direction_to(pos).angle(), 0.1)
	

func _closer_player() -> CharacterBody2D:
	if players.is_empty(): 
		return null
	var smallest_distance = INF
	var closest_player:CharacterBody2D = players[0]

	for player:CharacterBody2D in players:
		if player:
			var current_distance = global_position.distance_to(player.global_position)
			if  current_distance < smallest_distance:
				smallest_distance = current_distance
				closest_player = player
	return closest_player


func _push_forward(push_to:Vector2, push_force:int):
	var dir:Vector2 = global_position.direction_to(push_to)
	knockback = dir * push_force

func _look_at_player(pos:Vector2):
	rotation = lerp_angle(rotation, global_position.direction_to(pos).angle(), 0.1)

func _get_direction_to(target:Node2D) -> Vector2:
	return global_position.direction_to(target.global_position)

func move_to_player():
	#label.text = str(owner_node._closer_player())

	var closer_player = _closer_player()
	direction = global_position.direction_to(closer_player.global_position)
	_look_at_player(closer_player.global_position)


func _on_hurtbox_knockback_values(direction: Vector2, knockback_strength: int) -> void:
	knockback = knockback_receiver.apply_knockback(direction, knockback_strength)

func _on_hurtbox_killed() -> void:
	died.emit(self)
	if not is_dead: 
		if owner is root_node:
			print('1')
		owner._freeze_frame(0.1, 1.0)
		is_dead = true
		animation_player.play('killed')

func _on_boss_defence_hit() -> void:
	print('defence hit')
	animation_player.play('shield_hit')
