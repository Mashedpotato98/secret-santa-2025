extends Bullet

@onready var animation_player:AnimationPlayer = $AnimationPlayer

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
    queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
    print('brokie')
    #animation_player.play('broke')
    _die()
    hit(area)

    
func _die():
    animation_player.play('broke')