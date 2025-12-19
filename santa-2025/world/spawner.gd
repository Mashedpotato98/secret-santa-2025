extends Node2D

@onready var window_size:Vector2 = get_window().size
@onready var cooldown_timer:Timer = $Timer

@export var enemies:Array[PackedScene] = [] 
@export var score_label:Label 

func _ready() -> void:
	score_label.text = 'score:' + str(Global.wave_score)

func spawn():
	for enemy in enemies:
		var random_postiion:Vector2 = Vector2(randi_range(-window_size.x, window_size.x), randi_range(-window_size.y, window_size.y))
		var enemy_instance:CharacterBody2D = enemy.instantiate()
		enemy_instance.global_position = random_postiion
		enemy_instance.died.connect(_enemy_killed)
		get_tree().root.call_deferred("add_child", enemy_instance)
	
	cooldown_timer.start()

func _enemy_killed():
	Global.wave_score += 1
	score_label.text = "score:" + str(Global.wave_score)

func _on_timer_timeout() -> void:
	spawn()
