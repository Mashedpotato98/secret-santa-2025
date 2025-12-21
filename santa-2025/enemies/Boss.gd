extends CharacterBody2D

@onready var health_bar:TextureProgressBar = $CanvasLayer/health_bar
@onready var hitbox:hitBox = $hitbox
@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var hit_particle:GPUParticles2D = $hit_particle

@export var root_node:Node2D 

var direction:Vector2

func _ready() -> void:
    health_bar.value = $Sprite2D/hurtbox.max_hp
    $Sprite2D.material.set("shader_parameter/active", false) 
    #animation_player.play('killed')
    #_hit_animation()

func _physics_process(delta: float) -> void:
    pass

func _hit_animation(): #experiment
    var hit_tween:Tween = create_tween()
    var shader_tween:Tween = create_tween()
    hit_tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
    shader_tween.set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)

    $Sprite2D.scale = Vector2(0.5,0.5)
    $Sprite2D.material.set("shader_parameter/active", false) 

    hit_tween.tween_property($Sprite2D, "scale", Vector2(1.0,1.0), 0.3)
    shader_tween.tween_property($Sprite2D.material, "shader_parameter/active", false,0.3) 

func _on_hurtbox_got_hit(health: int) -> void:
    print(owner)
    if owner is root_node:
        owner._freeze_frame(0.5, 1)
        #owner._shake_camera(0.5) 
 
    animation_player.play('hurtbox_hit')
    health_bar.value = health

func _on_hitbox_area_entered(area: Area2D) -> void:
    if area is hurtBox:
        area.damage(hitbox)

func _on_hurtbox_killed() -> void:
    animation_player.play('killed')
    await animation_player.animation_finished
    get_tree().change_scene_to_file("res://world/thank_you.tscn")
