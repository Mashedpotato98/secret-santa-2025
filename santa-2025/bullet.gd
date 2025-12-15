class_name Bullet extends CharacterBody2D


@export var hitbox:hitBox
@export var speed:int = 1000

var direction:Vector2

func _physics_process(delta: float) -> void:
    velocity = direction * speed
    
    
    move_and_slide()


func hit(area:Area2D):
    if area is hurtBox:
        area.damage(hitbox)	
    elif area is bulletDefence:
        area.hit.emit()
        call_deferred('queue_free')
         
