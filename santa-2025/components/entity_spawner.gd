extends Node2D

signal timer_finished

@export var load_bullet:PackedScene 
@export var minion:PackedScene
@export var cooldown:Timer 
@export_range(0,2*PI) var alpha:float = 0.0
@export var father:Node2D 

var theta:float

func _start(time:float):
	cooldown.wait_time = time
	cooldown.start()

func spawn_bullet(angle:float):
	var bullet:CharacterBody2D = load_bullet.instantiate()
	
	bullet.direction = _get_vector(angle)
	bullet.position =  global_position
	
	get_tree().root.call_deferred('add_child', bullet)

func spawn_minion(angle:float):
	var minion:CharacterBody2D = minion.instantiate()

	minion.look_at(_get_vector(angle))  
	var force:int = randi_range(200,1100)

	get_tree().root.call_deferred('add_child', minion)

	minion._push_forward(_get_vector(angle), force)
	minion.global_position = father.global_position 

func _get_vector(angle):
	theta = angle + alpha
	return Vector2(cos(theta), sin(theta))


func _on_timer_timeout() -> void:
	timer_finished.emit()
