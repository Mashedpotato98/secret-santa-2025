class_name meleeChase extends State

func Enter():
	animation_player.stop()
	animation_player.play('RESET')

func physics_update(_delta:float):
	move_to_player()


func move_to_player():
	var closer_player = owner_node._closer_player()
	owner_node.direction = owner_node.global_position.direction_to(closer_player.global_position)
	animation_player.play("moving")
	owner_node.look_at(closer_player.global_position)
	animation_player.play('moving')


func _on_attack_area_body_entered(body: Node2D) -> void:
	Transitioned.emit(self , "meleeDrill")
	#owner_node.speed = 1
