extends CharacterBody2D

@onready var health_ui:Label = $CanvasLayer/Label
@onready var hurtbox:hurtBox = $hurtbox

@export var speed:int = 5

func _ready() -> void:
	health_ui.text = str(hurtbox.max_hp)

func _physics_process(delta: float) -> void:
	var direction:Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	velocity = direction * speed 
	move_and_slide()


func _on_hurtbox_got_hit() -> void:
	health_ui.text = str(hurtbox.hp)