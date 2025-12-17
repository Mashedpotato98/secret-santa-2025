extends CharacterBody2D

@export var regular_speed:int = 10
@export var dash_speed:int = 20
@export var dash_time:float = 0.1

@onready var speed:int = regular_speed
@onready var health_ui:Label = $CanvasLayer/Label
@onready var sword:Node2D = $sword
@onready var hurtbox:hurtBox = $hurtbox
@onready var knockback_receiver:Node2D = $knockback_receiver

var knockback:Vector2
var direction:Vector2


func _ready() -> void:
    health_ui.text = str(hurtbox.max_hp)

func _physics_process(delta: float) -> void:
    
    velocity = direction * speed + knockback
    knockback = lerp(knockback, Vector2.ZERO, 0.1)
    
    sword.global_rotation = direction.angle()

    move_and_slide()

    
func _on_hurtbox_got_hit(hp:int) -> void:
    health_ui.text = str(hurtbox.hp)


func _on_hurtbox_knockback_values(direction: Vector2, knockback_strength: int) -> void:
    print('direction: ' + str(direction) + ","  + 'strength:' + str(knockback_strength))
    knockback = knockback_receiver.apply_knockback(direction, knockback_strength)

