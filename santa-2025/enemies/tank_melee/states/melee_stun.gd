class_name meleeStun extends State

@export var hurtbox:hurtBox 

func Enter():
	if hurtbox.hp <= 0:
		owner_node.died.emit(owner_node)
		queue_free()
	else :
		if !animation_player.is_playing():
			animation_player.play('hit')
	await get_tree().create_timer(1.0).timeout
	Transitioned.emit(self, 'meleeChase')
	
func Exit():
	animation_player.play('RESET')
