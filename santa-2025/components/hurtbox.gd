class_name hurtBox extends Area2D

signal got_hit

@export var max_hp:int
@onready var hp:int = max_hp

func damage(hitbox:hitBox):
	hp -= hitbox.damage
	print(hp)
	if (hp <= 0):
		print("Should die")
		get_parent().queue_free()
	got_hit.emit()
	
		
	
