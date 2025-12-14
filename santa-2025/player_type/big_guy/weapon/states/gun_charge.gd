class_name gunCharge extends State

@export var holding:bool = false

func Enter():
	owner_node.slow_down_player()

func Exit():
	holding = false

func update(_delta:float):
	if Input.is_action_pressed('shoot') and holding == false:
		holding = true
		animation_player.play('charge')

		 
	if Input.is_action_just_released('shoot'):
		Transitioned.emit(self, 'gunIdle')

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if holding == true and anim_name == 'charge':
		Transitioned.emit(self, 'gunShoot')
