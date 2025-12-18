class_name meleeStun extends State


func Enter():
	await animation_player.animation_finished
	Transitioned.emit(self, "meleeChase")
	
func Exit():
	animation_player.play('RESET')
