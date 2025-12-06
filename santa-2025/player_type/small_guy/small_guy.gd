extends CharacterBody2D

@export var speed:int = 10

@onready var sword:Node2D = $sword

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("melee"):
		sword.sword_attack()


func _physics_process(delta: float) -> void:
	var direction:Vector2 = Input.get_vector("alt_left","alt_right","alt_up","alt_down")
	
	velocity = direction * speed
	move_and_slide()
