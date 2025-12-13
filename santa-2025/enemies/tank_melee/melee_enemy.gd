extends CharacterBody2D


@onready var big_guy:CharacterBody2D = get_tree().get_first_node_in_group("big_guy")
@onready var small_guy:CharacterBody2D = get_tree().get_first_node_in_group("small_guy")
@onready var hitbox:hitBox = $hitbox
@onready var knockback_receiver:Node2D = $knockback_receiver
@onready var players:Array[CharacterBody2D] = [big_guy, small_guy] 
@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var state:state_machine = $state_machine
@onready var attack_area:Area2D = $attack_area


@export var moving_speed:int = 70
@onready var speed:int = moving_speed

var direction:Vector2
var knockback:Vector2

var active:bool = false

func _ready() -> void:
	get_tree().create_timer(5).timeout
	active = true

func _physics_process(delta: float) -> void:
	velocity = direction * speed + knockback
	knockback = lerp(knockback, Vector2.ZERO, 0.1)
 
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
	
	
func _push_forward(push_to:Vector2, push_force:int):
	var dir:Vector2 = global_position.direction_to(push_to)
	knockback = dir * push_force

func _apply_knockback(direction:Vector2, knockback_strength:int):
	knockback = knockback_receiver.apply_knockback(direction, knockback_strength)

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is hurtBox:
		area.damage(hitbox)
		if players.has(hitbox.get_parent()):
			players.erase(hitbox.get_parent())

func _on_hurtbox_knockback_values(direction: Vector2, knockback_strength: int) -> void:
	attack_area.monitoring = false
	_apply_knockback(direction, knockback_strength)
	state.current_state.Transitioned.emit(state.current_state, 'meleeStun')


func _on_hurtbox_got_hit(health: int) -> void:
	#animation_player.stop()
	#print(animation_player.current_animation)
	pass
