class_name gunShoot extends State

@export var muzzle:Marker2D
@export var bullet_load:PackedScene
@export var shoot_icon:AnimationPlayer 

func Enter():
    animation_player.play('shoot')
    _instance_bullet()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
    if anim_name == 'shoot':
        Transitioned.emit(self, 'gunIdle')

func _instance_bullet():
    var bullet:Bullet = bullet_load.instantiate()
    bullet.global_position = muzzle.global_position
    bullet.direction = Vector2.from_angle(owner_node.rotation)
    get_tree().root.add_child(bullet)
