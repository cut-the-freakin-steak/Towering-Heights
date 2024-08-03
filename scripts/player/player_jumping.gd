extends State
class_name PlayerJumping

@export var player: CharacterBody2D
@export var animator: AnimationPlayer

var jump_height: float = 53
var jump_time_to_peak: float = 0.35
var jump_time_to_descent: float = 0.28

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1

@onready var coyote_timer = %CoyoteTimer
@onready var jump_buffer_timer = %JumpBufferTimer

func update(_delta):
	animator.play("jump")

func physics_update(_delta):
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		transitioned.emit(self, "running")
	
	else:
		player.velocity.x = 0
	
	if player.velocity.x == 0 and player.velocity.y == 0 and player.is_on_floor() and jump_buffer_timer.time_left == 0:
		transitioned.emit(self, "idle")
	
	elif player.is_on_floor() or coyote_timer.time_left > 0:
		jump()


func get_gravity() -> float:
	if player.velocity.y < 0.0:
		return jump_gravity
	
	else:
		return fall_gravity

func jump():
	player.velocity.y = jump_velocity
