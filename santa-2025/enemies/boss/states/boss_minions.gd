class_name bossMinion extends State

@export var minion_spawner:Node2D
@export var defence_breaker_load:PackedScene
@export var defence:bossDefence
@export var breaker_spawn_cooldown:Timer
@export var defence_cooldown:Timer
@export var minion_spawn_cooldown:int = 1
@export var melee_spawn_threshold:int = 5

@onready var window_size:Vector2 = get_window().size

var defence_breakers_list:Array[Area2D] = []
var defence_breaker:Area2D

var active:bool = false
var melees_spawned:int = 0

func Enter():
	active = true
	_defence_on()

func Exit():
	defence.disable()

func spawn_defence_breaker(): 
	print('spawning defence breaker')
	var random_position:Vector2 = Vector2(randi_range(10, 1142), randi_range(10, 638))
	defence_breaker = defence_breaker_load.instantiate() 

	defence_breaker.position = random_position
	defence_breaker.body_entered.connect(_on_defence_broken)
	
	add_child(defence_breaker)
	#defence_breakers_list.append(defence_breaker)

func _defence_on():
	print('defence on')
	defence.enable()
	breaker_spawn_cooldown.start()
	minion_spawner._start(minion_spawn_cooldown)
	animation_player.play('defence_on')

func _defence_off():
	print('defence off')
	defence.disable()
	defence_cooldown.start()
	minion_spawner.cooldown.stop()
	animation_player.play('defence_off')

#defence broken by capturing defennce breaker node
func _on_defence_broken(body:CharacterBody2D):
	print('defence_broken')
	animation_player.play('defence_broken')
	defence_breaker.queue_free()
	_defence_off()

func _spawn_minion():
	if melees_spawned < melee_spawn_threshold: 
		var melee_enemy:CharacterBody2D = minion_spawner.melee_enemy_load.instantiate()
		animation_player.play('spawn_melee')
		minion_spawner.spawn_minion(melee_enemy, minion_spawner.theta)
		melees_spawned += 1
	else :
		melees_spawned = 0
		var shield_enemy:CharacterBody2D = minion_spawner.shield_enemy_load.instantiate()
		animation_player.play('spawn_shield')
		minion_spawner.spawn_minion(shield_enemy, minion_spawner.theta)

func _on_bullet_spawner_timer_finished() -> void:
	#print('1')
	if active == true:
		_spawn_minion()

#breaker spawn cooldown. Defence ON -> here
func _on_breaker_spawn_cooldown_timeout() -> void:
	print('breaker spawn cooldown.')
	spawn_defence_breaker()

#defence cooldown finished. Defence OFF -> here
func _on_defence_cooldown_timeout() -> void:
	print('defence cooldown finished.')
	_defence_on()

func _on_boss_defence_hit() -> void:
	animation_player.play('defence_hit')
