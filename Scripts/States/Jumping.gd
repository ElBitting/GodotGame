extends PlayerState
class_name PlayerJumping

@export var jumpbuffer := .1
var jumptimer: float = 0
var reenter: bool = false

func Enter():
	player.velocity.y = -player.jumpspeed
	sprite.play("jump")
	
func Exit():
	jumptimer = 0
	
func Update(_delta: float):
	var jump = Input.is_action_just_pressed("jump")
	if jumptimer <= 0 and jump:
		jumptimer = jumpbuffer
	jumptimer -= _delta
	

func Physics_Update(_delta: float):
	#short jump
	if Input.is_action_just_released("jump") and player.velocity.y < 0:
		player.velocity.y = player.velocity.y * player.shortjump
	elif reenter and not Input.is_action_pressed('jump'):
		player.velocity.y = player.velocity.y * player.shortjump
	reenter = false
	#slightly faster fall
	if player.velocity.y > 0:
		player.velocity.y += player.gravity * player.gravitymult * _delta
	else:
		player.velocity.y += player.gravity * _delta
	
	#sprite flipping
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
		
	#sideways movement
	if direction:
		player.velocity.x = direction * player.movespeed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.movespeed)
		
	#state transition
	if player.is_on_floor() and jumptimer > 0:
		reenter = true
		Transitioned.emit(self,'jumping')
	elif player.is_on_floor() and direction:
		Transitioned.emit(self, 'running')
	elif player.is_on_floor():
		Transitioned.emit(self, 'idle')

		
