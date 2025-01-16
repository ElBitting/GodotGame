extends Node
class_name PlayerState

@export var player: CharacterBody2D
@export var sprite: AnimatedSprite2D


signal Transitioned

func Enter():
	pass
	
func Exit():
	pass
	
func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass
