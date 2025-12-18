class_name shieldInactive extends State

@export var idle_timer:Timer 

func Enter():
	idle_timer.start()

func _on_idle_timer_timeout() -> void:
	Transitioned.emit(self, 'shieldMove')
