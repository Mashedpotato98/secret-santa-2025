extends Node2D

@onready var hitbox:hitBox = $hitbox   
@onready var animation_player:AnimationPlayer = $AnimationPlayer

@export var manager:CharacterBody2D 


func _physics_process(delta: float) -> void:
	global_position = manager.global_position

func sword_attack(): 
	animation_player.play("atttack")

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is hurtBox:
		area.damage(hitbox)
