extends Node

var score = 0

@onready var coin_counter = $CoinCounter
@onready var player = %Player

func add_point():
	score += 1
	coin_counter.text = "You collected " + str(score) + " coins."

func pick_up_dagger():
	player.has_jade_dagger = true
