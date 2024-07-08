extends State
class_name PlayerIdle

@export var player: CharacterBody2D
@export var animator: AnimatedSprite2D

func update(_delta):
    animator.play("idle")

func physics_update(_delta):
    if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
        transitioned.emit(self, "running")
    
    if Input.is_action_just_pressed("jump"):
        transitioned.emit(self, "jumping")