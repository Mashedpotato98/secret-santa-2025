extends Bullet

@export var max_hit:int
@onready var current_hit:int = max_hit

signal hit_defence

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_hitbox_area_entered(area: Area2D) -> void:
	hit(area)
	queue_free()
