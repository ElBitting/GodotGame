extends PlayerState
class_name PlayerIdle

@export var player: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var movespeed := 10.0

func Enter():
	sprite.play('idle')
	
	
func Exit():
	pass
	
func Update(_delta: float):
	if player.is_on_floor and Input.get_axis("move_left", "move_right"):
		Transitioned.emit(self, 'running')
		
	if player.is_on_floor and Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, 'jumping')
	if not player.is_on_floor():
		Transitioned.emit(self, 'falling')
		


func Physics_Update(_delta: float):
	pass
