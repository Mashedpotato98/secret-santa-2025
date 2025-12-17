extends CharacterBody2D

@onready var health_bar:ProgressBar = $CanvasLayer/health_bar
@onready var hitbox:hitBox = $hitbox

var direction:Vector2

func _physics_process(delta: float) -> void:
    pass


func _on_hurtbox_got_hit(health: int) -> void:
    health_bar.value = health


func _on_hitbox_area_entered(area: Area2D) -> void:
    if area is hurtBox:
        area.damage(hitbox)
