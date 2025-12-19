class_name meleeChase extends State

@export var label:Label
@export var attack_area:Area2D

func Enter():
    animation_player.play("moving")
    owner_node.speed = owner_node.moving_speed

func Exit():
    #label.text = ""
    pass

func physics_update(_delta:float):
    if owner_node._closer_player() != null:
        move_to_player()

func move_to_player():
    #label.text = str(owner_node._closer_player())

    var closer_player = owner_node._closer_player()
    owner_node.direction = owner_node.global_position.direction_to(closer_player.global_position)
    owner_node.look_at(closer_player.global_position)
    animation_player.play('moving')


func _on_attack_area_body_entered(body: Node2D) -> void:
    print(body)
    Transitioned.emit(self , "meleeCharge")
    #owner_node.speed = 1
