class_name meleeStun extends State

@export var hurtbox:hurtBox 

func Enter():
    await get_tree().create_timer(1.0).timeout
    Transitioned.emit(self, 'meleeChase')
    
func Exit():
    animation_player.play('RESET')
