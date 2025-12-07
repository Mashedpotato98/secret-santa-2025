extends CharacterBody2D

@onready var health_ui:Label = $CanvasLayer/Label
@onready var knockback_receiver:Node2D = $knockback_receiver
@onready var hurtbox:hurtBox = $hurtbox

@export var speed:int = 5

var knockback:Vector2 #to be set by hitbox

func _ready() -> void:
    health_ui.text = str(hurtbox.max_hp)

func _physics_process(delta: float) -> void:
    var direction:Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
    
    velocity = direction * speed + knockback
    knockback = lerp(knockback, Vector2.ZERO, 0.1)
    move_and_slide()


func _on_hurtbox_got_hit(health:int)-> void:
    health_ui.text = str(health) 

func _on_hurtbox_knockback_values(direction: Vector2, knockback_strength: int) -> void:
    knockback = knockback_receiver.apply_knockback(direction, knockback_strength)    