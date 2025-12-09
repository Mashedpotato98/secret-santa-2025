class_name hurtBox extends Area2D

signal got_hit(health:int)
signal knockback_values(direction:Vector2, knockback_strength:int)

@export var max_hp:int
@onready var hp:int = max_hp

func damage(hitbox:hitBox):
	hp -= hitbox.damage
	if (hp <= 0):
		#if get_parent().is_in_group('big_guy') or get_parent().is_in_group('small_guy'):
			#get_tree().reload_current_scene()
		get_parent().queue_free()
	var direction:Vector2 = global_position.direction_to(hitbox.global_position)
	got_hit.emit(hp)
	knockback_values.emit(direction, hitbox.knockback_strength)
	
		
	
