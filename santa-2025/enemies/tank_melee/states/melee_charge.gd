class_name meleeCharge extends State

@onready var closer_player:CharacterBody2D  

@export var charge_timer:Timer
@export var ram_line:Line2D 

func Enter():
    #var closer_player:CharacterBody2D = owner_node._closer_player()
    #if closer_player: #indent the next lines if needed
    owner_node.speed = owner_node.ram_speed

    closer_player = closer_player
    owner_node._closer_position()
    owner_node.look_at(owner_node.closer_player_position)

    ram_line.add_point(owner_node.to_local(owner_node.global_position + Vector2.from_angle(owner_node.rotation)) * 10)
    var pos:Vector2 = (owner_node.to_local(owner_node.closer_player_position).normalized()) * 700 * 0.2 
    ram_line.add_point(pos)

    animation_player.play('charge')
    await animation_player.animation_finished
    Transitioned.emit(self , "meleeRam")  

    
func Exit():
    ram_line.clear_points()
    animation_player.play('RESET')
    
func _on_charge_time_timeout() -> void:
    pass
    #print('hello')
    #Transitioned.emit(self , "meleeRam")
