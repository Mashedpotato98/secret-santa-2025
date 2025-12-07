extends CharacterBody2D

@onready var big_guy:CharacterBody2D = get_tree().get_first_node_in_group("big_guy")
@onready var small_guy:CharacterBody2D = get_tree().get_first_node_in_group("small_guy")
@onready var hitbox:hitBox = $hitbox
@onready var knockback_receiver:Node2D = $knockback_receiver
@onready var players:Array[CharacterBody2D] = [big_guy, small_guy] 

@export var speed:int = 70
	
var direction:Vector2
var knockback:Vector2

func _physics_process(delta: float) -> void:
	velocity = direction * speed + knockback
	knockback = lerp(knockback, Vector2.ZERO, 0.1)

	if !players.is_empty():
		move_to_player()

	move_and_slide()
	

func _closer_player() -> CharacterBody2D:
    #if player[0]: indent all
	var smallest_distance = global_position.distance_to(players[0].global_position)
	var closest_player:CharacterBody2D = players[0]

	for player:CharacterBody2D in players:
		if player:
			var current_distance = global_position.distance_to(player.global_position)
			if  current_distance <= smallest_distance:
				smallest_distance = global_position.distance_to(player.global_position)
				closest_player = player

	return closest_player
	
func move_to_player():
	if !players.is_empty():
		direction = global_position.direction_to(_closer_player().global_position)
	
func check_existence():
	pass

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is hurtBox:
		print(area)
		area.damage(hitbox)


func _on_hurtbox_knockback_values(direction: Vector2, knockback_strength: int) -> void:
	knockback = knockback_receiver.apply_knockback(direction, knockback_strength)
