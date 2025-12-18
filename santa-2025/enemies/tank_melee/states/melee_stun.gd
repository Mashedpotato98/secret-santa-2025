class_name meleeStun extends State

@export var hurtbox:hurtBox 

func Enter():
    if hurtbox.hp > 0: 
        await animation_player.animation_finished
        Transitioned.emit(self, "meleeChase")
    else :
        animation_player.play('RESET')
        animation_player.play('killed')
    
func Exit():
    animation_player.play('RESET')
