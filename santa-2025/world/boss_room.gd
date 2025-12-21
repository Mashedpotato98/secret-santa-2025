class_name root_node extends Node2D

@export var camera:cam 

func _ready():
	Engine.time_scale = 1.0
	_freeze_frame(0.5,0.1)

func _freeze_frame(time_scale:float, freeze_time:float):
	Engine.time_scale = time_scale
	await get_tree().create_timer(freeze_time,true, false, true)
	_shake_camera(0.5)
	Engine.time_scale = 1.0

func _shake_camera(powah:float):
	camera.add_trauma(powah)
	
