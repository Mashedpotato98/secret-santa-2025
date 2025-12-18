class_name shieldIdle extends State

@export var idle_timer:Timer

func Enter():
    idle_timer.start()
    idle_timer.timeout.connect(_idle_timer_timeout)

    
func _idle_timer_timeout():
    Transitioned.emit(self, 'shieldMove')
