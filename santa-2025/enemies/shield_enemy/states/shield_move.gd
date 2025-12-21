class_name shieldMove extends State

@export var move_timer:Timer 

func Enter():
	move_timer.start()
	owner_node.speed = owner_node.regular_speed

func physics_update(_delta:float):
	if owner_node._closer_player() and owner_node.is_dead == false:
		owner_node.move_to_player()

func _on_move_timer_timeout() -> void:
	Transitioned.emit(self, 'shieldDefence')
