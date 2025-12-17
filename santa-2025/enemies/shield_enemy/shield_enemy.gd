extends CharacterBody2D

@onready var animation_player:AnimationPlayer = $AnimationPlayer

@onready var big_guy:CharacterBody2D = get_tree().get_first_node_in_group("big_guy")
@onready var small_guy:CharacterBody2D = get_tree().get_first_node_in_group("small_guy")
@onready var players:Array[CharacterBody2D] = [big_guy, small_guy] 
@onready var knockback_receiver:Node2D = $knockback_receiver


@export var speed:int = 10

var direction:Vector2 
var knockback:Vector2


func _physics_process(delta: float) -> void:
    velocity = direction * speed + knockback 
    knockback = lerp(knockback, Vector2.ZERO, 0.1) 
    
    move_and_slide()

func _look_at(target:Vector2, delta : float):
    var angle = (target - self.global_position).angle()
    self.global_rotation = lerp_angle(self.global_rotation, angle, delta)

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


func _on_hurtbox_knockback_values(direction: Vector2, knockback_strength: int) -> void:
    knockback = knockback_receiver._apply_knockback(direction, knockback_strength)
