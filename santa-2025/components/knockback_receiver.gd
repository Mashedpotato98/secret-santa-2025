extends Node2D

@export var body:CharacterBody2D   

func apply_knockback(direction:Vector2, knockback_strength:int):
    var knockback:Vector2 = -direction * knockback_strength
    return knockback

func set_knockback(direction:Vector2, knockback_strength: int):
    body.knockback = apply_knockback(direction, knockback_strength)

