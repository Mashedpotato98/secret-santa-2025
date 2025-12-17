class_name bossDefence extends Area2D

signal hit;

@export var collision_:CollisionShape2D  
	
func disable():
	collision_.set_deferred('disabled', true)
func enable():
	collision_.set_deferred('disabled', false)
