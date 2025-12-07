extends CharacterBody2D

@export var regular_speed:int = 10
@export var dash_speed:int = 20
@export var dash_cooldown:float = 0.3

@onready var speed:int = regular_speed
@onready var health_ui:Label = $CanvasLayer/Label
@onready var sword:Node2D = $sword
@onready var hurtbox:hurtBox = $hurtbox
@onready var knockback_receiver:Node2D = $knockback_receiver

var knockback:Vector2

func _ready() -> void:
	health_ui.text = str(hurtbox.max_hp)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("melee"):
		sword.sword_attack()

	if Input.is_action_just_pressed("dash"):
		print("dash")
		dash()
	
	sword_direction(event)


func _physics_process(delta: float) -> void:
	var direction:Vector2 = Input.get_vector("alt_left","alt_right","alt_up","alt_down")
	
	velocity = direction * speed + knockback
	knockback = lerp(knockback, Vector2.ZERO, 0.1)

	move_and_slide()

	
func dash():
	speed = dash_speed
	await get_tree().create_timer(0.1).timeout
	speed = regular_speed
	
func sword_direction(_event:InputEvent):
	if _event.is_action_pressed("alt_left"):
		sword.rotation = Vector2.LEFT.angle()
	if _event.is_action_pressed("alt_right"):
		sword.rotation = Vector2.RIGHT.angle()

	if _event.is_action_pressed("alt_up"):
		sword.rotation = Vector2.UP.angle()
	if _event.is_action_pressed("alt_down"):
		sword.rotation = Vector2.DOWN.angle()


func _on_hurtbox_got_hit(hp:int) -> void:
	health_ui.text = str(hurtbox.max_hp)


func _on_hurtbox_knockback_values(direction: Vector2, knockback_strength: int) -> void:
	knockback = knockback_receiver.apply_knockback(direction, knockback_strength)
