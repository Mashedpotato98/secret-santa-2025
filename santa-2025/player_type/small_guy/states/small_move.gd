class_name smallMove extends State

@export var dash_cooldown:Timer
@export var dash_animation:AnimationPlayer 

var can_dash:bool = true

func Enter():
	owner_node.speed = owner_node.regular_speed

func physics_update(_delta:float): 
	owner_node.direction = Input.get_vector('2_left', '2_right', '2_up', '2_down')
	if Input.is_action_just_pressed("melee"):
		Transitioned.emit(self, 'smallMelee')

	if Input.is_action_just_pressed("dash") and can_dash == true:
		dash()
	
func dash():
	can_dash = false
	owner.speed = owner_node.dash_speed
	animation_player.play('dash')

	await get_tree().create_timer(0.1).timeout

	owner_node.speed = owner_node.regular_speed
	dash_animation.play('hide_dash_icon')
	dash_cooldown.start()
	animation_player.stop()
	
func _on_dash_cooldown_timeout() -> void:
	can_dash = true
	dash_animation.play('show_dash_icon')
