class_name meleeIdle extends State

@export var idle_timer:Timer

func Enter():
    idle_timer.start()
    #idle_timer.timeout.connect(_on_timeout)

#func _on_timeout():
    #Transitioned.emit(self, 'meleeChase')


func _on_idle_timer_timeout() -> void:
   Transitioned.emit(self, 'meleeChase') 