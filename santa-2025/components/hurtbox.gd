class_name hurtBox extends Area2D

signal got_hit(health:int)
signal knockback_values(direction:Vector2, knockback_strength:int)

@export var max_hp:int
@onready var hp:int = max_hp
@export var owner_node:CharacterBody2D

func damage(hitbox:hitBox):
	hp -= hitbox.damage
	if (hp <= 0):
		owner_node.queue_free()
	var direction:Vector2 = global_position.direction_to(hitbox.get_parent().global_position)
	got_hit.emit(hp)
	knockback_values.emit(direction, hitbox.knockback_strength)
	
		
	
