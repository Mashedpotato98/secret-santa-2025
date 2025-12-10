class_name gunIdle extends State

@export var cooldown_timer:Timer 

var can_shoot:bool = false

func Enter():
	can_shoot = false
	cooldown_timer.start()
	print('Idle, can_shoot:' + str(can_shoot))
	animation_player.stop()
	animation_player.play('RESET')

		

func update(_delta: float):
	if Input.is_action_pressed('shoot') and can_shoot == true:
		Transitioned.emit(self, "gunCharge")

func _on_cooldown_timer_timeout() -> void:
	print('COOLDOWN OVERRRR')
	can_shoot = true
