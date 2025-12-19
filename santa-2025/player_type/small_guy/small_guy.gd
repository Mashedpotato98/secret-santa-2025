extends CharacterBody2D

@export var regular_speed:int = 10
@export var dash_speed:int = 20
@export var dash_time:float = 0.1

@onready var speed:int = regular_speed
#@onready var health_ui:Label = $CanvasLayer/Label
@onready var sword:Node2D = $sword
@onready var hurtbox:hurtBox = $hurtbox
@onready var knockback_receiver:Node2D = $knockback_receiver
@onready var health_bar:TextureProgressBar = $CanvasLayer/health_bar
@onready var hud_animation_player:AnimationPlayer = $health_animation
@onready var dash_animation:AnimationPlayer = $dash_animation


var knockback:Vector2
var direction:Vector2
var rotational_direction:Vector2

func _ready() -> void:
	#health_bar.visible = false
	health_bar.value = hurtbox.max_hp
	hud_animation_player.play('show_health')
	dash_animation.play('show_dash_icon')

func _physics_process(delta: float) -> void:
	
	velocity = direction * speed + knockback
	knockback = lerp(knockback, Vector2.ZERO, 0.1)

	if direction != Vector2.ZERO: 
		rotational_direction = direction
	
	
	sword.global_rotation = rotational_direction.angle()

	move_and_slide()

	
func _on_hurtbox_got_hit(hp:int) -> void:
	#health_bar.visible = true
	health_bar.value = hp
	hud_animation_player.play('show_health')
	$hit_sound.play()


func _on_hurtbox_knockback_values(direction: Vector2, knockback_strength: int) -> void:
	knockback = knockback_receiver.apply_knockback(direction, knockback_strength)


func _on_hurtbox_killed() -> void:
	queue_free()
