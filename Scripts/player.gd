extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var jumpspeed := 300.0
@export var movespeed := 150
@export var gravitymult := 1.5

func _physics_process(delta):

	move_and_slide()
