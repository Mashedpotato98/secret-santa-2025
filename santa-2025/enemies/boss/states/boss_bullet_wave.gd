class_name bossBulletWave extends State


@export var bullet_spawner:Node2D
@export var hurtbox:hurtBox
@export var spawn_cooldown:float = 1.0
@export var shoot_sound:AudioStreamPlayer2D 
@export var stage_change_timer:Timer
@export var pattern_change_particle:GPUParticles2D  
@export var still_going_particle:GPUParticles2D

@export var health_change_state:int = 10

var active:bool = false
var wait:bool = false

var stage_1_alpha:float = 3
var stage_2_alpha:float = 6
var stage_3_alpha:float = 4

@onready var current_alpha:float = stage_1_alpha

func Enter():
	await get_tree().create_timer(1.0).timeout
	active = true
	bullet_spawner._start(spawn_cooldown)
	stage_change_timer.start()
	if !animation_player.is_playing():
		animation_player.play('spawn_bullet')
	

func Exit():
	active = false
	animation_player.stop()

func _on_bullet_spawner_timer_finished() -> void:
	if active == true and wait == false:
		if !shoot_sound.playing:
			shoot_sound.play() 

		bullet_spawner.spawn_bullet(bullet_spawner.theta)


func _on_hurtbox_got_hit(health: int) -> void:
	if health <= health_change_state:
		if active == true:
			await get_tree().create_timer(2.0).timeout
			still_going_particle.emitting = true
			pattern_change_particle.emitting = false
			Transitioned.emit(self, 'bossMinion') 

func _on_bullet_change_timeout() -> void:
	if active == true:
		wait = true
		await get_tree().create_timer(1.0).timeout
		pattern_change_particle.emitting = true
		wait = false
		match bullet_spawner.alpha:
			stage_1_alpha:
				bullet_spawner.alpha = stage_2_alpha
			stage_2_alpha:
				bullet_spawner.alpha = stage_3_alpha
			stage_3_alpha:
				bullet_spawner.alpha = stage_1_alpha
		
