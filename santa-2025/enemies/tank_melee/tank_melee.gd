extends CharacterBody2D

@onready var big_guy:CharacterBody2D = get_tree().get_first_node_in_group("big_guy")
@onready var small_guy:CharacterBody2D = get_tree().get_first_node_in_group("small_guy")
@onready var hitbox:hitBox = $hitbox
@onready var players:Array[CharacterBody2D] = [big_guy, small_guy] 

@export var speed:int = 70
	


func _physics_process(delta: float) -> void:
	if big_guy and small_guy:
		move_to_player()
	move_and_slide()
	

func _closer_player() -> CharacterBody2D:
	var smallest_distance = global_position.distance_to(players[0].global_position)
	var closest_player:CharacterBody2D = players[0]

	for player:CharacterBody2D in players:
		var current_distance = global_position.distance_to(player.global_position)
		if  current_distance <= smallest_distance:
			smallest_distance = global_position.distance_to(player.global_position)
			closest_player = player

	return closest_player
	
func move_to_player():
	var direction:Vector2 = global_position.direction_to(_closer_player().global_position)
	
	velocity = direction * speed

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is hurtBox:
		print(area)
		area.damage(hitbox)
