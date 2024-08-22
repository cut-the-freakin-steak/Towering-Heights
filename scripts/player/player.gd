extends CharacterBody2D
class_name Player

const SPEED = 120.0
const ACCELERATION = 23
const FRICTION = 30

var is_attack_playing = false
var is_attacking = false
var is_sliding = false
var is_slide_jumping = false
var has_jade_dagger = false
var is_ground_pounding = false
var last_direction

var jump_height: float = 53
var jump_time_to_peak: float = 0.35
var jump_time_to_descent: float = 0.28

@onready var jump_velocity: float = ((2.0 * jump_height) / jump_time_to_peak) * -1
@onready var jump_gravity: float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1
@onready var fall_gravity: float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1

@onready var animated_sprite = $AnimatedSprite2D
@onready var animator = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var attack_animation_timer = %AttackAnimationTimer
@onready var attack_timer = %AttackTimer
@onready var jump_buffer_timer = %JumpBufferTimer
@onready var slide_jump_timer = %SlideJumpTimer
@onready var coyote_timer = %CoyoteTimer

func _physics_process(delta):
	var direction = Input.get_axis("move_left", "move_right")
	
	# Add the gravity.
	velocity.y += get_new_gravity() * delta
	

	# Handle jump buffer
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer.start()

	# Flip the sprite
	if direction > 0:
		sprite_2d.flip_h = false
		animated_sprite.flip_h = false
	
	elif direction < 0:
		sprite_2d.flip_h = true
		animated_sprite.flip_h = true
	
	if sprite_2d.flip_h == false:
		last_direction = 1
	
	elif sprite_2d.flip_h == true:
		last_direction = -1
	
	# Flip the attack collision
	if Input.is_action_pressed("move_right"):
		get_node("JadeDaggerCollision").set_scale(Vector2(1, 1))
	elif Input.is_action_pressed("move_left"): 
		get_node("JadeDaggerCollision").set_scale(Vector2(-1, 1))

	
	if has_jade_dagger == true:
		if Input.is_action_just_pressed("attack") and !is_attacking and !is_on_floor():
			jade_aerial_attack()
		
		elif Input.is_action_just_pressed("attack") and !is_attacking and (Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")):
			jade_running_attack()
			
		elif Input.is_action_just_pressed("attack") and !is_attacking and is_on_floor():
			jade_grounded_attack()
			
	
	# Sliding
	if (Input.is_action_just_pressed("slide") and is_on_floor()) or (Input.is_action_just_pressed("slide") and !is_on_floor() and is_sliding):
		slide_jump_timer.start()

	elif Input.is_action_just_pressed("slide") and !is_on_floor() and !is_sliding:
		is_sliding = false

	elif !Input.is_action_pressed("slide"):
		is_sliding = false
	
	# Coyote Time Implementation
	var was_on_floor = is_on_floor()

	move_and_slide()

	var just_left_ledge = was_on_floor and !is_on_floor() and velocity.y >= 0

	if just_left_ledge:
		coyote_timer.start()


func get_new_gravity() -> float:
	if velocity.y < 0.0:
		return jump_gravity
	
	else:
		return fall_gravity


func jade_grounded_attack():
	animator.play("attack")
	$JadeDaggerCollision/CollisionShape2D.disabled = false
	is_attack_playing = true
	is_attacking = true
	attack_animation_timer.start()
	attack_timer.start()

func jade_aerial_attack(): 
	animator.play("attack_jump")
	$JadeDaggerCollision/CollisionShape2D.disabled = false
	is_attack_playing = true
	is_attacking = true
	attack_animation_timer.start()
	attack_timer.start()

func jade_running_attack():
	animator.play("attack_run")
	$JadeDaggerCollision/CollisionShape2D.disabled = false
	is_attack_playing = true
	is_attacking = true
	attack_animation_timer.start()
	attack_timer.start()


func _on_attack_animation_timer_timeout():
	is_attack_playing = false
	$JadeDaggerCollision/CollisionShape2D.disabled = true

func _on_attack_timer_timeout():
	is_attacking = false

func _on_slide_jump_timer_timeout():
	is_slide_jumping = false
