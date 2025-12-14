class_name gunIdle extends State

@export var cooldown_timer:Timer 

var can_shoot:bool = false

func Enter():
    owner_node.revert_player_speed()
    can_shoot = false

    cooldown_timer.start()

    animation_player.stop()
    animation_player.play('RESET')


        

func update(_delta: float):
    if Input.is_action_pressed('shoot') and can_shoot == true:
        Transitioned.emit(self, "gunCharge")

func _on_cooldown_timer_timeout() -> void:
    can_shoot = true
