extends State
class_name PlayerRunning

@export var player: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D
# @export var animator: AnimationPlayer

@onready var jump_buffer_timer = %JumpBufferTimer

func physics_update(_delta):
	# Handle input.
	var input_direction = input()
	if input_direction != Vector2.ZERO:
		accelerate(input_direction)
		if player.is_on_floor():
			animated_sprite.play("run")
		
		else:
			animated_sprite.play("jump")
	
	# Deceleration
	else:
		add_friction()

	if player.velocity.x == 0:
		transitioned.emit(self, "idle")

	if Input.is_action_just_pressed("jump") or (jump_buffer_timer.time_left > 0 and player.is_on_floor()):
		transitioned.emit(self, "jumping")
	
	if Input.is_action_pressed("slide") and player.is_on_floor():
		transitioned.emit(self, "sliding")

func accelerate(direction):
	player.velocity.x = player.velocity.move_toward(player.SPEED * direction, player.ACCELERATION).x

func add_friction():
	player.velocity.x = player.velocity.move_toward(Vector2.ZERO, player.FRICTION).x

func input() -> Vector2:
	var input_direction = Vector2.ZERO

	input_direction.x = Input.get_axis("move_left", "move_right")
	return input_direction
