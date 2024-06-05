extends Area2D

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer


func _on_body_entered(_body):
	game_manager.pick_up_dagger()
	animation_player.play("pickup")
