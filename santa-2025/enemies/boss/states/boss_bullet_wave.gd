class_name bossBulletWave extends State

@export var bullet_spawner:Node2D
@export var spawn_cooldown:float = 1.0

var active:bool = false

func Enter():
	active = true
	bullet_spawner._start(spawn_cooldown)

func Exit():
	active = false

func _on_bullet_spawner_timer_finished() -> void:
	if active == true:
		bullet_spawner.spawn_bullet(bullet_spawner.theta)
