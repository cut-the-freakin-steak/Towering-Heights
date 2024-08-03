extends State
class_name PlayerSlide

@export var player: CharacterBody2D
@export var animator: AnimationPlayer

@onready var slide_jump_timer = %SlideJumpTimer

const SLIDE_SPEED = 220.0
const SLIDE_JUMP_SPEED = 470

func update(_delta):
	animator.play("slide")

func physics_update(_delta):
	if Input.is_action_pressed("slide"):
		if Input.is_action_just_pressed("jump") and slide_jump_timer.time_left > 0:
			player.velocity.x = SLIDE_JUMP_SPEED * player.last_direction
			transitioned.emit(self, "jumping")
		
		elif Input.is_action_just_pressed("jump") and slide_jump_timer.time_left == 0:
			player.velocity.x = SLIDE_SPEED * player.last_direction
			transitioned.emit(self, "jumping")
		
		else:
			player.velocity.x = SLIDE_SPEED * player.last_direction
	
	if !Input.is_action_pressed("slide"):
		player.velocity.x = 0.0
		transitioned.emit(self, "idle")
	
	if !Input.is_action_pressed("slide") and (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
		transitioned.emit(self, "running")
