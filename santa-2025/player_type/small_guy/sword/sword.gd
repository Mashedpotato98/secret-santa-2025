extends Node2D

signal melee_finished

@onready var hitbox:hitBox = $pivot/Sprite2D/hitbox   
@onready var animation_player:AnimationPlayer = $AnimationPlayer

		
func _attack(): animation_player.play("attack")
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is hurtBox:  
		area.damage(hitbox)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'attack':
		melee_finished.emit()
