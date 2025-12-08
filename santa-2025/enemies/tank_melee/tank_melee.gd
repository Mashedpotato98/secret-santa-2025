extends CharacterBody2D

@onready var big_guy:CharacterBody2D = get_tree().get_first_node_in_group("big_guy")
@onready var small_guy:CharacterBody2D = get_tree().get_first_node_in_group("small_guy")
@onready var hitbox:hitBox = $hitbox
@onready var knockback_receiver:Node2D = $knockback_receiver
@onready var players:Array[CharacterBody2D] = [big_guy, small_guy] 
@onready var animation_player:AnimationPlayer = $AnimationPlayer


@export var moving_speed:int = 70
@onready var speed:int = moving_speed



var direction:Vector2
var knockback:Vector2

enum states {
	moving,
	attack
}

var current_state:states = states.moving

func _physics_process(delta: float) -> void:
	velocity = direction * speed + knockback
	knockback = lerp(knockback, Vector2.ZERO, 0.1)

	match current_state:
		states.moving:
			moving()
		states.attack:
			drill_attack()
	
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
		var closer_player = _closer_player()
		direction = global_position.direction_to(closer_player.global_position)
		animation_player.play("moving")
		look_at(closer_player.global_position)

func moving():
	if !players.is_empty():
		move_to_player()

	
func _look_at_player(pos:Vector2):
	look_at(pos)

func drill_attack():
	_look_at_player(_closer_player().global_position)
	animation_player.play("attack")
	
func _push_forward(push_to:Vector2):
	var dir:Vector2 = global_position.direction_to(push_to)
	velocity += dir * knockback
	print(velocity)
	print(dir)
	


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area is hurtBox:
		area.damage(hitbox)


func _on_hurtbox_knockback_values(direction: Vector2, knockback_strength: int) -> void:
	knockback = knockback_receiver.apply_knockback(direction, knockback_strength)


func _on_attack_area_body_entered(body: Node2D) -> void:
	#speed = 1
	_push_forward(body.global_position)
	current_state = states.attack

func _on_attack_area_body_exited(body: Node2D) -> void:
	speed = moving_speed
	animation_player.play('RESET')
	current_state = states.moving
	
