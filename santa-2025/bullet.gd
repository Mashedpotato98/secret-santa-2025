extends CharacterBody2D

@onready var hitbox:hitBox = $hitbox

@export var speed:int = 1000
var direction:Vector2

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	
	
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is hurtBox:
		area.damage(hitbox)	
