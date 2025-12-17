class_name meleeStun extends State


func Enter():
	owner_node.velocity = owner_node.velocity.move_toward(Vector2.ZERO, 0.1)
	await animation_player.animation_finished
	Transitioned.emit(self, "meleeChase")
	
func Exit():
	animation_player.play('RESET')
