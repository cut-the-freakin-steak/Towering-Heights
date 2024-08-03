extends State
class_name PlayerIdle

@export var player: CharacterBody2D
@export var animator: AnimationPlayer

@onready var jump_buffer_timer = %JumpBufferTimer

func update(_delta):
	if player.velocity.x == 0 and player.velocity.y == 0:
		animator.play("idle")
	
	else:
		animator.play("run")

func physics_update(_delta):
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		transitioned.emit(self, "running")
	
	if Input.is_action_just_pressed("jump") or (player.is_on_floor() and jump_buffer_timer.time_left > 0):
		transitioned.emit(self, "jumping")
	
	if Input.is_action_pressed("slide") and player.is_on_floor():
		transitioned.emit(self, "sliding")
