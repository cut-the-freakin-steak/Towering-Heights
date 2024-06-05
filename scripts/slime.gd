extends Node2D

const SPEED = 60
var direction = 1
var dead = false

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dead == false:
		if ray_cast_right.is_colliding():
			direction = -1
			animated_sprite.flip_h = true
		
		if ray_cast_left.is_colliding():
			direction = 1
			animated_sprite.flip_h = false
		
		position.x += direction * SPEED * delta


func _on_hitbox_area_entered(area):
	if area.is_in_group("sword"):
		dead = true
		queue_free()
