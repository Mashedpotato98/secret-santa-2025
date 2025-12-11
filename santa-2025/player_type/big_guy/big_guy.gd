extends CharacterBody2D

@onready var health_ui:Label = $CanvasLayer/Label
@onready var knockback_receiver:Node2D = $knockback_receiver
@onready var hurtbox:hurtBox = $hurtbox

@export var regular_speed:int = 100
@export var shoot_speed:int = 1

@onready var speed:int = regular_speed

var player_index:int = 0

var knockback:Vector2 #to be set by hitbox
var direction:Vector2

@onready var custom_input:DeviceInput = DeviceInput.new(player_index)

func _ready() -> void:
	health_ui.text = str(hurtbox.max_hp)

func _physics_process(delta: float) -> void:
	
	velocity = direction * speed + knockback
	knockback = lerp(knockback, Vector2.ZERO, 0.1)

	move_and_slide()
	
	if custom_input.is_action_pressed('left'):
		print(custom_input.device)

func _input(event: InputEvent) -> void:
	if event.device == player_index:
		direction = Input.get_vector("left", "right", "up", "down")


func _on_hurtbox_got_hit(health:int)-> void:
	health_ui.text = str(health) 

func _on_hurtbox_knockback_values(direction: Vector2, knockback_strength: int) -> void:
	knockback = knockback_receiver.apply_knockback(direction, knockback_strength)    
