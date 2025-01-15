extends PlayerState
class_name PlayerRunning


func Enter():
	sprite.play('run')
	
func Exit():
	pass
	
func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
		
	if direction:
		player.velocity.x = direction * movespeed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, movespeed)
	if not direction and player.is_on_floor():
		Transitioned.emit(self, 'idle')
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, 'jumping')
	if not player.is_on_floor():
		Transitioned.emit(self, 'falling')
