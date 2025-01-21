extends PlayerState
class_name PlayerFalling

@export var jumpbuffer := 0.15
@export var coyotetime := 0.1

var coyotetimer: float = 0 
var jumptimer: float = 0
var rolltimer: float = 0

func Enter():
	sprite.play('jump')
	coyotetimer = coyotetime
	
func Exit():
	pass
	
func Update(_delta: float):
	if coyotetimer > 0:
		coyotetimer += -_delta
	jumptimer -= _delta
	rolltimer -= _delta
	
	if player.is_on_floor() and jumptimer > 0:
		Transitioned.emit(self,'jumping')
	elif player.is_on_floor() and rolltimer > 0:
		Transitioned.emit(self, 'rolling')
	elif player.is_on_floor() and Input.get_axis("move_left", "move_right"):
		Transitioned.emit(self, 'running')
	elif player.is_on_floor():
		Transitioned.emit(self, 'idle')
	

func Physics_Update(_delta: float):
	if coyotetimer < 0: 
		player.velocity.y += player.gravity * _delta * player.gravitymult
	else: 
		player.velocity.y += player.gravity * _delta*.5
	
	var direction = Input.get_axis("move_left", "move_right")
	var jump = Input.is_action_just_pressed("jump")
	var roll = Input.is_action_just_pressed("dash")
	if jump:
		jumptimer = jumpbuffer
	if roll:
		rolltimer = jumpbuffer
	if jump and coyotetimer > 0:
		Transitioned.emit(self,'jumping')
	if roll and coyotetimer > 0:
		Transitioned.emit(self,'rolling')
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
		
	if direction:
		player.velocity.x = direction * player.movespeed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.movespeed)
