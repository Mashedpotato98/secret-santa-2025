class_name State extends Node

@export var owner_node:Node2D
@export var animation_player:AnimationPlayer

signal Transitioned(current_state,new_state_name)

func Enter():
	pass

func Exit():
	pass

func update(_delta:float):
	pass

func physics_update(_delta:float):
	pass