class_name bossMinion extends State

@export var minion_spawner:Node2D
@export var spawn_cooldown:float = 1.0

var active:bool = false

func Enter():
    active = true
    minion_spawner._start(spawn_cooldown)

func _on_bullet_spawner_timer_finished() -> void:
    if active == true:
        animation_player.play('spawn_minion')
        minion_spawner.spawn_minion(minion_spawner.theta)
