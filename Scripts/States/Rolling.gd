extends PlayerState
class_name PlayerRoll

@export var RollTimer: Timer

func Enter():
	sprite.play('roll')
	RollTimer.start(player.rollLength)
	
	
func Exit():
	pass
	
func Update(_delta: float):
	pass
		

func Physics_Update(_delta: float):
	if sprite.flip_h:
		player.velocity.x = -player.rollspeed
	else:
		player.velocity.x = player.rollspeed
		
	if not player.is_on_floor():
		player.velocity.y  += player.gravity * _delta*.3
		
	var direction = Input.get_axis("move_left", "move_right")
		
	if RollTimer.is_stopped():
		if player.is_on_floor and direction:
			player.velocity.x = player.movespeed * direction
			Transitioned.emit(self, 'running')
		elif player.is_on_floor and Input.is_action_just_pressed("jump"):
			player.velocity.x = player.velocity.x/2
			Transitioned.emit(self, 'jumping')
		elif not player.is_on_floor():
			player.velocity.x = player.velocity.x/2
			Transitioned.emit(self, 'falling')
		else:
			player.velocity.x = 0
			Transitioned.emit(self, 'idle')
			
