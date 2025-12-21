extends Node2D


@onready var cooldownTimer:Timer = $cooldownTimer
@onready var muzzle:Marker2D = $Sprite2D/Marker2D
@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var visual_aim:Line2D = $aim_direction

@export var big_guy:CharacterBody2D 
@export var canShoot:bool = true


func _process(delta: float) -> void:
	pass    

func _visual_aim(line:Line2D, direction:Vector2):
	line.points[1] = direction


		

func slow_down_player():
	big_guy.speed = big_guy.shoot_speed
func revert_player_speed():
	big_guy.speed = big_guy.regular_speed
