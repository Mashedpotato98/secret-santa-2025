extends Node2D

signal melee_finished

@onready var hitbox:hitBox = $hitbox   
@onready var animation_player:AnimationPlayer = $AnimationPlayer

        
func _attack(): animation_player.play("attack")
    
func _on_hitbox_area_entered(area: Area2D) -> void:
    if area is hurtBox:  
        area.damage(hitbox)
    elif area is bossDefence:
        animation_player.call_deferred('play', 'hit_defence')
        area.hit.emit()
        print("betha bro")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    melee_finished.emit()


func _on_player_defence_hit() -> void:
    $audio/broken_sound.play() 