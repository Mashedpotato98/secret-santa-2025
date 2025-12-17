extends Node2D


@onready var cooldownTimer:Timer = $cooldownTimer
@onready var muzzle:Marker2D = $Marker2D
@onready var animation_player:AnimationPlayer = $AnimationPlayer

@export var big_guy:CharacterBody2D 
@export var canShoot:bool = true

var aim_direction:Vector2 

func _process(delta: float) -> void:
	if big_guy:
		global_position = big_guy.global_position

		
func slow_down_player():
	big_guy.speed = big_guy.shoot_speed
func revert_player_speed():
	big_guy.speed = big_guy.regular_speed
