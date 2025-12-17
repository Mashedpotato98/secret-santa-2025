extends CharacterBody2D

@onready var health_ui:Label = $CanvasLayer/Label
@onready var knockback_receiver:Node2D = $knockback_receiver
@onready var hurtbox:hurtBox = $hurtbox
@onready var weapon:Node2D = $Big_weapon

@export var regular_speed:int = 100
@export var shoot_speed:int = 5

@onready var speed:int = regular_speed

var player_index:int = 2

var knockback:Vector2 #to be set by hitbox
var direction:Vector2
var rotational_direction:Vector2

func _ready() -> void:
	health_ui.text = str(hurtbox.max_hp)

func _physics_process(delta: float) -> void:
	#direction = Input.get_vector('1_left' % player_index, '1_right' % player_index, '1_up' % player_index, '1_down' % player_index)
	direction = Input.get_vector('1_left', '1_right', '1_up', '1_down')
	velocity = direction * speed + knockback
	knockback = lerp(knockback, Vector2.ZERO, 0.1)

	if direction != Vector2.ZERO:
		weapon.global_position = global_position

	if Global.current_input == Global.input_mode.CONTROLLER_MIX:
		var aim_direction:Vector2  = Input.get_vector('aim_left', 'aim_right', 'aim_up', 'aim_down')
		if aim_direction != Vector2.ZERO:
			rotational_direction = aim_direction
	else :
		rotational_direction = global_position.direction_to(get_global_mouse_position())
	
	weapon.rotation = rotational_direction.angle()

	move_and_slide()
	

func _on_hurtbox_got_hit(health:int)-> void:
	health_ui.text = str(health) 

func _on_hurtbox_knockback_values(direction: Vector2, knockback_strength: int) -> void:
	knockback = knockback_receiver.apply_knockback(direction, knockback_strength)    
