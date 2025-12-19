class_name shieldDefence extends State

@export var defence_timer:Timer 
@export var bullet_spawner:Node2D

@export var bullet_spawn_cooldown:int

func Enter():
	if bullet_spawner:
		bullet_spawner._start(bullet_spawn_cooldown)
	defence_timer.start()
	
	animation_player.play('defence')
	
	owner_node.speed = owner_node.defence_speed

func physics_update(_delta:float):
	if owner_node._closer_player():
		owner_node.move_to_player()

func _on_defence_timer_timeout() -> void:
	return

func _on_entity_spawner_timer_finished() -> void:
	var closer_player = owner_node._closer_player()
	if closer_player:
		animation_player.play('shoot')
		await animation_player.animation_finished
		
		var direction_to:Vector2 = owner_node._get_direction_to(closer_player)
		bullet_spawner.spawn_bullet(direction_to.angle())


func _on_boss_defence_hit() -> void:
	pass # Replace with function body.
