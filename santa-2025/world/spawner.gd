extends Node2D

@onready var cooldown_timer:Timer = $Timer

@export var enemy_list_0:Array[PackedScene] = [] 
@export var enemy_list_1:Array[PackedScene] = []
@export var enemy_list_2:Array[PackedScene] = []
@export var enemy_list_3:Array[PackedScene] = []
@export var enemy_list_4:Array[PackedScene] = []
@export var enemy_list_5:Array[PackedScene] = []

@onready var enemy_lists:Array[Array] = [enemy_list_0, enemy_list_1, enemy_list_2, enemy_list_3, enemy_list_4, enemy_list_5]

@export var score_label:Label 
@export var level_threshold:int

var spawn_points:Array[Marker2D] 
var current_level:int 
var enemy_in_wave:int
var enemies_killed_in_wave:int #enemies killed in current wave

func _ready() -> void:
	for child in get_children():
		if child is Marker2D:
			spawn_points.append(child)

	score_label.text = 'score:' + str(Global.wave_score)
	_advanced_spawn()

#func spawn():
	#for enemy in enemies:
		#var random_postiion:Vector2 = Vector2(randi_range(-window_size.x, window_size.x), randi_range(-window_size.y, window_size.y))
		#var enemy_instance:CharacterBody2D = enemy.instantiate()
		#enemy_instance.global_position = random_postiion
		#jenemy_instance.died.connect(_enemy_killed)
		#get_tree().root.call_deferred("add_child", enemy_instance)
	
#cooldown_timer.start()

func _advanced_spawn():
	enemies_killed_in_wave = 0
	enemy_in_wave = 0

	var list:Array[PackedScene] = enemy_lists.pick_random()
	print(list)
	for enemy:PackedScene in list:
		var instance:CharacterBody2D = enemy.instantiate()
		instance.global_position = _random_spawn_point()
		instance.died.connect(_enemy_killed)
 
		get_tree().root.call_deferred("add_child", instance)
	enemy_in_wave = list.size()
	print("enemies in wave:" + str(enemy_in_wave))
		
func _random_spawn_point() -> Vector2:
	return spawn_points.pick_random().global_position

func _enemy_killed(_type:CharacterBody2D):
	enemies_killed_in_wave += 1
	var increase_by:int = 0
	if _type is meleeEnemy:
		increase_by = 1
	if _type is shieldEnemy:
		increase_by = 2
		
	Global.wave_score += increase_by
	score_label.text = "score:" + str(Global.wave_score)

	print("enemies killed in wave:" + str(enemies_killed_in_wave))
	if enemies_killed_in_wave >= enemy_in_wave:
		#enemy_in_wave = 0
		#enemies_killed_in_wave = 0
		cooldown_timer.start() 

func _on_timer_timeout() -> void:
	_advanced_spawn()
