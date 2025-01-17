extends PlayerState
class_name PlayerJumping

@export var jumpbuffer := .2
var jumptimer: float = 0

func Enter():
	player.velocity.y = -player.jumpspeed
	sprite.play("jump")
	
func Exit():
	pass
	
func Update(_delta: float):
	var jump = Input.is_action_just_pressed("jump")
	if jump and jumptimer <= 0:
		jumptimer = jumpbuffer
	jumptimer -= _delta
	

func Physics_Update(_delta: float):
	if Input.is_action_just_released("jump") and player.velocity.y < 0:
		player.velocity.y = player.velocity.y * player.shortjump
	if player.velocity.y > 0:
		player.velocity.y += player.gravity * player.gravitymult * _delta
	else:
		player.velocity.y += player.gravity * _delta
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
		
	if direction:
		player.velocity.x = direction * player.movespeed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.movespeed)
		
	if player.is_on_floor() and jumptimer > 0:
		jumptimer = 0
		Transitioned.emit(self,'jumping')
	elif player.is_on_floor() and direction:
		Transitioned.emit(self, 'running')
	elif player.is_on_floor():
		Transitioned.emit(self, 'idle')

		
