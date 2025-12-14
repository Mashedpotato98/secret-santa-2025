class_name bossBulletWave extends State


@export var bullet_spawner:Node2D
@export var hurtbox:hurtBox
@export var spawn_cooldown:float = 1.0

@onready var health_change_state:int = 10

var active:bool = false

func Enter():
	active = true
	bullet_spawner._start(spawn_cooldown)
	animation_player.play('spawn_bullet')

func Exit():
	active = false
	animation_player.stop()

func _on_bullet_spawner_timer_finished() -> void:
	if active == true:
		bullet_spawner.spawn_bullet(bullet_spawner.theta)


func _on_hurtbox_got_hit(health: int) -> void:
	if health <= health_change_state:
		Transitioned.emit(self, 'bossMinion') 
