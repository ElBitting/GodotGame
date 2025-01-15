extends Area2D

#game manager is a unique node! we cannot reuse this name ever but shouldnt need to anyways
@onready var game_manager = %"Game Manager"
@onready var animation_player = $AnimationPlayer



func _on_body_entered(body):
	game_manager.add_point()
	animation_player.play("pickup")
