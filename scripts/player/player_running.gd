extends State
class_name PlayerRunning

@export var player: CharacterBody2D

func physics_update(_delta):
    var input_direction = input()
    if input_direction != Vector2.ZERO:
        accelerate(input_direction)
    else:
        add_friction()

func accelerate(direction):
    player.velocity.x = player.velocity.move_toward(player.SPEED * direction, player.ACCELERATION).x

func add_friction():
    player.velocity.x = player.velocity.move_toward(Vector2.ZERO, player.FRICTION).x

func input() -> Vector2:
    var input_direction = Vector2.ZERO

    input_direction.x = Input.get_axis("move_left", "move_right")
    return input_direction
