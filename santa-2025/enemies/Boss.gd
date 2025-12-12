extends CharacterBody2D

@onready var health_bar:ProgressBar = $CanvasLayer/health_bar

var direction:Vector2

func _physics_process(delta: float) -> void:
	pass


func _on_hurtbox_got_hit(health: int) -> void:
	health_bar.value = health
