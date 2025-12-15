class_name meleeDrill extends State

@onready var closer_player:CharacterBody2D  

@export var push_force:int = 1

func Enter():
	closer_player = owner_node._closer_player()
	owner_node.speed = owner_node.drill_speed 

	animation_player.play('charge')
	
	await animation_player.animation_finished

	owner_node._push_forward(closer_player.global_position, push_force )
	animation_player.play('attack')

	await animation_player.animation_finished
	Transitioned.emit(self , "meleeChase")
	


func physics_update(_delta:float):
	drill_attack()
	owner_node.look_at(closer_player.global_position)

func drill_attack():
	#closer_player = owner_node._closer_player()
	#animation_player.play('attack')
	pass


func _on_attack_area_body_exited(body: Node2D) -> void:
	pass
	#Transitioned.emit(self , "meleeChase")
