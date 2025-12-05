extends Node2D

var bullet:PackedScene = preload("res://player_type/big_guy/weapon/bullet.tscn")

@onready var cooldownTimer:Timer = $cooldownTimer
@export var big_guy:CharacterBody2D 
var canShoot:bool = true

func _process(delta: float) -> void:
	global_position = big_guy.global_position
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot") and canShoot == true:
		shoot()

func shoot():
	var bullet_ins:CharacterBody2D = bullet.instantiate()
	bullet_ins.global_position = global_position
	bullet_ins.direction = big_guy.velocity.direction_to(get_global_mouse_position())
	get_tree().root.add_child(bullet_ins)
	canShoot = false
	cooldownTimer.start()

func _on_cooldown_timer_timeout() -> void:
	canShoot = true
