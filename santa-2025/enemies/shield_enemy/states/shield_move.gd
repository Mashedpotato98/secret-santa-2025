class_name shieldMove extends State

func physics_update(_delta:float):
    if owner_node._closer_player():
        move_to_player()

func move_to_player():
    #label.text = str(owner_node._closer_player())

    var closer_player = owner_node._closer_player()
    owner_node.direction = owner_node.global_position.direction_to(closer_player.global_position)
    owner_node.look_at(closer_player.global_position)
    #animation_player.play('moving')

func _on_move_timer_timeout() -> void:
    print('1')    
