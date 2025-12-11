class_name smallMove extends State

@export var dash_cooldown:Timer

func Enter():
	owner_node.speed = owner_node.regular_speed

func update(_delta:float): 
	if Input.is_action_just_pressed("melee"):
		Transitioned.emit(self, 'smallMelee')

	if Input.is_action_just_pressed("dash") and owner_node.can_dash == true:
		dash()

func physics_update(_delta:float): 
	owner_node.direction = Input.get_vector("alt_left","alt_right","alt_up","alt_down")
	
func dash():
	owner_node.can_dash = false
	owner.speed = owner_node.dash_speed
	await get_tree().create_timer(0.1).timeout
	owner_node.speed = owner_node.regular_speed
	dash_cooldown.start()
	
func _on_dash_cooldown_timeout() -> void:
	owner_node.can_dash = true
