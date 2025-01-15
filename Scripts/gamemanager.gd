extends Node

var score = 0

@onready var text_score = $Score


func add_point():
	score += 1
	text_score.text = str(score)
