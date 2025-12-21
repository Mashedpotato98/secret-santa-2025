class_name bossBulletWave extends State


@export var bullet_spawner:Node2D
@export var hurtbox:hurtBox
@export var spawn_cooldown:float = 1.0
@export var shoot_sound:AudioStreamPlayer2D 

@export var health_change_state:int = 10

var active:bool = false

func Enter():
	await get_tree().create_timer(1.0).timeout
	active = true
	bullet_spawner._start(spawn_cooldown)
	if !animation_player.is_playing():
		animation_player.play('spawn_bullet')

func Exit():
	active = false
	animation_player.stop()

func _on_bullet_spawner_timer_finished() -> void:
	if active == true:
		if !shoot_sound.playing:
			shoot_sound.play() 

		bullet_spawner.spawn_bullet(bullet_spawner.theta)


func _on_hurtbox_got_hit(health: int) -> void:
	if health <= health_change_state:
		Transitioned.emit(self, 'bossMinion') 
