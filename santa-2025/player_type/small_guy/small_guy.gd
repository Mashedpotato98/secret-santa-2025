extends CharacterBody2D

@export var regular_speed:int = 10
@export var dash_speed:int = 20
@export var dash_cooldown:float = 0.3

@onready var speed:int = regular_speed

@onready var sword:Node2D = $sword

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("melee"):
		sword.sword_attack()
	if Input.is_action_just_pressed("dash"):
		print("dash")
		dash()


func _physics_process(delta: float) -> void:
	var direction:Vector2 = Input.get_vector("alt_left","alt_right","alt_up","alt_down")
	sword.rotation = direction.angle()
	
	velocity = direction * speed
	move_and_slide()

	
func dash():
	speed = dash_speed
	await get_tree().create_timer(0.1).timeout
	speed = regular_speed