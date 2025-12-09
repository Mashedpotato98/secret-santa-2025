class_name meleeStun extends State


func Enter():
    owner_node.velocity = Vector2.ZERO
    animation_player.play('hit')
    await animation_player.animation_finished
    Transitioned.emit(self, "meleeChase")
