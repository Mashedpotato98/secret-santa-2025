class_name meleeCharge extends State

@onready var closer_player:CharacterBody2D  

@export var charge_timer:Timer

func Enter():
	#var closer_player:CharacterBody2D = owner_node._closer_player()
	#if closer_player: #indent the next lines if needed
	owner_node.speed = owner_node.ram_speed

	closer_player = closer_player
	owner_node._closer_position()
	owner_node.look_at(owner_node.closer_player_position)

	animation_player.play('charge')
	await animation_player.animation_finished
	Transitioned.emit(self , "meleeRam")  

	
func Exit():
	animation_player.play('RESET')
	
func _on_charge_time_timeout() -> void:
	pass
	#print('hello')
	#Transitioned.emit(self , "meleeRam")
