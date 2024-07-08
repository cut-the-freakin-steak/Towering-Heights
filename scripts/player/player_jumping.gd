extends State
class_name PlayerJumping

@export var player: CharacterBody2D

var jump_height: float = 53
var jump_time_to_peak: float = 0.35
var jump_time_to_descent: float = 0.28

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1

@onready var coyote_timer = %CoyoteTimer
@onready var jump_buffer_timer = %JumpBufferTimer

func physics_update(_delta):
	if (player.is_on_floor() or coyote_timer.time_left > 0):
		if Input.is_action_just_pressed("jump"):
			jump()
	
	if player.is_on_floor():
		if jump_buffer_timer.time_left > 0:
			jump()


func get_gravity() -> float:
	if player.velocity.y < 0.0:
		return jump_gravity
	
	else:
		return fall_gravity

func jump():
	player.velocity.y = jump_velocity
