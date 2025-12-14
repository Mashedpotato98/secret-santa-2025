extends CharacterBody2D

@onready var health_ui:Label = $CanvasLayer/Label
@onready var knockback_receiver:Node2D = $knockback_receiver
@onready var hurtbox:hurtBox = $hurtbox

@export var regular_speed:int = 100
@export var shoot_speed:int = 5

@onready var speed:int = regular_speed

var player_index:int = 2

var knockback:Vector2 #to be set by hitbox
var direction:Vector2


func _ready() -> void:
	health_ui.text = str(hurtbox.max_hp)

func _physics_process(delta: float) -> void:
	#direction = Input.get_vector('1_left' % player_index, '1_right' % player_index, '1_up' % player_index, '1_down' % player_index)
	direction = Input.get_vector('1_left', '1_right', '1_up', '1_down')
	velocity = direction * speed + knockback
	knockback = lerp(knockback, Vector2.ZERO, 0.1)
	

	move_and_slide()
	

func _on_hurtbox_got_hit(health:int)-> void:
	health_ui.text = str(health) 

func _on_hurtbox_knockback_values(direction: Vector2, knockback_strength: int) -> void:
	knockback = knockback_receiver.apply_knockback(direction, knockback_strength)    
