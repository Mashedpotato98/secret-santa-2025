extends Node2D

var bullet:PackedScene = preload("res://player_type/big_guy/weapon/bullet.tscn")

@onready var cooldownTimer:Timer = $cooldownTimer
@onready var muzzle:Marker2D = $Marker2D
@onready var animation_player:AnimationPlayer = $AnimationPlayer

@export var big_guy:CharacterBody2D 
@export var canShoot:bool = true
@export var owner_speed:int = 20


func _process(delta: float) -> void:
	if big_guy:
		global_position = big_guy.global_position
	look_at(get_global_mouse_position())
	#if Input.is_action_just_pressed("shoot") and canShoot == true:
		#charge()

#func shoot():
	#canShoot = false
	#cooldownTimer.start()

#func charge():
	#animation_player.play('charge')

#func _charge_shoot():
	#animation_player.play('shoot')


#func _set_owner_speed(shooting:bool):
	#if shooting == true:
		#big_guy.speed = big_guy.shoot_speed
	#else:
		#big_guy.speed = big_guy.regular_speed

#func release_shoot():
	#canShoot = false
	#cooldownTimer.start()
	#_set_owner_speed(false)
	#animation_player.stop()
	#animation_player.play("RESET")

#func _on_cooldown_timer_timeout() -> void:
	#canShoot = true

#func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#if anim_name == "charge":
		#_charge_shoot()
