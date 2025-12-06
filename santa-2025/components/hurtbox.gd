class_name hurtBox extends Area2D

signal got_hit

@export var max_hp:int
@onready var hp:int = max_hp

func damage(hitbox:hitBox):
	hp -= hitbox.damage
	if (hp <= 0):
		get_parent().queue_free()
	got_hit.emit()
	
		
	
