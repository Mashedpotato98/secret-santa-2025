extends CharacterBody2D

signal died

@onready var big_guy:CharacterBody2D = get_tree().get_first_node_in_group("big_guy")
@onready var small_guy:CharacterBody2D = get_tree().get_first_node_in_group("small_guy")
@onready var hitbox:hitBox = $areas/hitbox
@onready var knockback_receiver:Node2D = $areas/knockback_receiver
@onready var players:Array[CharacterBody2D] = [big_guy, small_guy] 
@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var state:state_machine = $state_machine
@onready var attack_area:Area2D = $areas/attack_area
@onready var soft_collision:Area2D = $areas/soft_collision
@onready var hurtbox:hurtBox = $areas/hurtbox

@export var soft_collision_strength:int = 1
@export var moving_speed:int = 70
@export var ram_speed:int = 0

@onready var speed:int = moving_speed

var direction:Vector2
var knockback:Vector2

var active:bool = false
var closer_player_position:Vector2



func _physics_process(delta: float) -> void:
	velocity = direction * speed + knockback
	knockback = lerp(knockback, Vector2.ZERO, 0.1)

	for soft_collider in soft_collision.get_overlapping_bodies():
		print(soft_collider)

 
	move_and_slide()
	

func _closer_player() -> CharacterBody2D:
	if players.is_empty(): 
		return null
	var smallest_distance = INF
	var closest_player:CharacterBody2D = players[0]

	for player:CharacterBody2D in players:
		if player:
			var current_distance = global_position.distance_to(player.global_position)
			if  current_distance < smallest_distance:
				smallest_distance = current_distance
				closest_player = player
	return closest_player

func _closer_position():
	closer_player_position = _closer_player().global_position
	return closer_player_position 
	
	
func _push_forward(push_to:Vector2, push_force:int):
	var dir:Vector2 = global_position.direction_to(push_to)
	knockback = dir * push_force

func _apply_knockback(direction:Vector2, knockback_strength:int):
	knockback = knockback_receiver.apply_knockback(direction, knockback_strength)

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is hurtBox:
		area.damage(hitbox)
		#if players.has(area.owner_node):
			#players.erase(area.owner_node)

func _on_hurtbox_knockback_values(direction: Vector2, knockback_strength: int) -> void:
	_apply_knockback(direction, knockback_strength)
	if hurtbox.hp > 0:
		state.current_state.Transitioned.emit(state.current_state, 'meleeStun')
		animation_player.play('hit')
	else :
		animation_player.play('killed')

func _on_hurtbox_got_hit(health: int) -> void:
	print(health)

func _on_soft_collision_area_entered(area: Area2D) -> void:
	var dir:Vector2 = (global_position.direction_to(area.global_position))
	_apply_knockback(dir, soft_collision_strength) 
	
	#for soft_collider in soft_collision.get_overlapping_bodies():
		#print(soft_collider)

func _on_state_machine_changed(state, new_state) -> void:
	#$state.text = str(new_state)
	pass

func _on_hurtbox_killed() -> void:
	died.emit() 
	animation_player.play('RESET')
	animation_player.play("killed")
