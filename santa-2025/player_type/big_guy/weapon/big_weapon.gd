extends Node2D


@onready var cooldownTimer:Timer = $cooldownTimer
@onready var muzzle:Marker2D = $Marker2D
@onready var animation_player:AnimationPlayer = $AnimationPlayer

@export var big_guy:CharacterBody2D 
@export var canShoot:bool = true


func _process(delta: float) -> void:
	if big_guy:
		global_position = big_guy.global_position
		var aim_direction:Vector2 = Input.get_vector('aim_left', 'aim_right', 'aim_up', 'aim_down')
		global_rotation = aim_direction.angle()
		
func slow_down_player():
	big_guy.speed = big_guy.shoot_speed
func revert_player_speed():
	big_guy.speed = big_guy.regular_speed
