class_name meleeRam extends State

@export var ram_timer:Timer
@export var push_force:int = 1

func Enter():
	owner_node.velocity = Vector2.ZERO 

	animation_player.play('attack')

	owner_node._push_forward(owner_node.closer_player_position, push_force)

	ram_timer.start()


func _on_ram_time_timeout() -> void:
	Transitioned.emit(self, 'meleeChase')
