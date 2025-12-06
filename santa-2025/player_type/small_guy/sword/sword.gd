extends Node2D

@onready var hitbox:hitBox = $pivot/Sprite2D/hitbox   
@onready var animation_player:AnimationPlayer = $AnimationPlayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("melee"):
		sword_attack()
		

func sword_attack(): animation_player.play("atttack")
	


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is hurtBox:  
		area.damage(hitbox)
		print(area)
