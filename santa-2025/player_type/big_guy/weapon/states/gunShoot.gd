class_name gunShoot extends State

func Enter():
	animation_player.play('shoot')

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'shoot':
		Transitioned.emit(self, 'gunIdle')
