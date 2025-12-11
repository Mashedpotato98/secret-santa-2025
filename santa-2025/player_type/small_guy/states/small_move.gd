class_name smallMove extends State

@export var dash_cooldown:Timer

@export var player_index:int = 1

func Enter():
	owner_node.speed = owner_node.regular_speed

func update(_delta:float): 
	if Input.is_action_just_pressed("melee"):
		Transitioned.emit(self, 'smallMelee')

	if Input.is_action_just_pressed("dash") and owner_node.can_dash == true:
		dash()

func physics_update(_delta:float): 
	pass
	
func _input(event: InputEvent) -> void:
	if event.device == player_index:
		owner_node.direction = Input.get_vector("alt_left","alt_right","alt_up","alt_down")
		

func dash():
	owner_node.can_dash = false
	owner.speed = owner_node.dash_speed
	await get_tree().create_timer(0.1).timeout
	owner_node.speed = owner_node.regular_speed
	dash_cooldown.start()
	
func _on_dash_cooldown_timeout() -> void:
	owner_node.can_dash = true
