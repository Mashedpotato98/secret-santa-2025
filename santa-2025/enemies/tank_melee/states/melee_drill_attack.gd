class_name meleeDrill extends State

@onready var closer_player:CharacterBody2D  

@export var push_force:int = 1

func Enter():
    closer_player = owner_node._closer_player()
    owner_node.speed = owner_node.drill_speed 
    owner_node._push_forward(closer_player.global_position, push_force )

func physics_update(_delta:float):
    drill_attack()

func drill_attack():
    closer_player = owner_node._closer_player()
    owner_node.look_at(closer_player.global_position)


func _on_attack_area_body_exited(body: Node2D) -> void:
    Transitioned.emit(self , "meleeChase")
