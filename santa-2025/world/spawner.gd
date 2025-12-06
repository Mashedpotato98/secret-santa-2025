extends Node2D

@onready var window_size:Vector2 = get_window().size
@onready var cooldown_timer:Timer = $Timer

var enemies:Array[PackedScene] = [preload("res://enemies/tank_melee/tank_melee.tscn")] 


func spawn():
    for enemy in enemies:
        var random_postiion:Vector2 = Vector2(randi_range(-window_size.x, window_size.x), randi_range(-window_size.y, window_size.y))
        print(random_postiion)
        var enemy_instance:CharacterBody2D = enemy.instantiate()
        enemy_instance.global_position = random_postiion
        get_tree().root.call_deferred("add_child", enemy_instance)
    
    cooldown_timer.start()

func _on_timer_timeout() -> void:
    spawn()