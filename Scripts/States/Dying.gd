extends PlayerState
class_name PlayerDying


func Enter():
	player.velocity.x = 0
	
func Exit():
	pass
	
func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass
