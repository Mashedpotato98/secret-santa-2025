extends Bullet

signal hit_defence

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func hit(area:Area2D):
	super(area)
	if area is bossDefense:
	   get_parent().queue_free() 

func _on_hitbox_area_entered(area: Area2D) -> void:
	print('yo')
	hit(area)
