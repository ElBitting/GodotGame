extends PlayerState
class_name PlayerJumping

func Enter():
	player.velocity.y = -player.jumpspeed
	sprite.play("jump")
	
func Exit():
	pass
	
func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
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
		
	if player.is_on_floor() and direction:
		Transitioned.emit(self, 'running')
	elif player.is_on_floor():
		Transitioned.emit(self, 'idle')

		
