extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var jumpspeed := 300.0
@export var movespeed := 150
@export var gravitymult := 1.7
@export var shortjump := .5
@export var rollspeed := 350
@export var rollLength := .7

func _physics_process(delta):

	move_and_slide()
