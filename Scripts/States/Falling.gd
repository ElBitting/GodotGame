extends PlayerState
class_name PlayerFalling


@export var player: CharacterBody2D
@export var sprite: AnimatedSprite2D
@export var JUMP_VELOCITY := 300.0
@export var movespeed := 150

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func Enter():
	sprite.play('jump')
	
func Exit():
	pass
	
func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	player.velocity.y += gravity * _delta
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
		
	if direction:
		player.velocity.x = direction * movespeed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, movespeed)
		
	if player.is_on_floor() and direction:
		Transitioned.emit(self, 'running')
	elif player.is_on_floor():
		Transitioned.emit(self, 'idle')
