extends State
class_name PlayerSlideJump

@export var player: CharacterBody2D

var jump_height: float = 53
var jump_time_to_peak: float = 0.35
var jump_time_to_descent: float = 0.28

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1

func physics_update(_delta):
    jump()
    player.velocity.x = (player.SPEED + 350) * player.last_direction


func get_gravity() -> float:
    if player.velocity.y < 0.0:
        return jump_gravity
	
    else:
        return fall_gravity

func jump():
    player.velocity.y = jump_velocity