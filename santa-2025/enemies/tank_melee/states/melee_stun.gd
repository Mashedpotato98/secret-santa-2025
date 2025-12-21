class_name meleeStun extends State

@export var hurtbox:hurtBox 

func Enter():
    animation_player.play('hit')
    if hurtbox.hp <= 0:
        owner_node.died.emit(owner_node)
        queue_free()
    await get_tree().create_timer(1.0).timeout
    Transitioned.emit(self, 'meleeChase')
    
func Exit():
    animation_player.play('RESET')
