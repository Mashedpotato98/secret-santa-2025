class_name smallMelee extends State

@export var sword:Node2D 

func Enter():
	owner_node.velocity = Vector2.ZERO
	owner_node.speed = 0
	sword._attack()

func _on_sword_melee_finished() -> void:
	Transitioned.emit(self, 'smallMove')
