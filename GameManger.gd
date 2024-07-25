extends Node2D

@export var PlayerPos: Vector2 = Vector2(0,0)
@export var Player: CharacterBody2D

func _ready():
	pass

func _process(delta):
	if Player != null:
		PlayerPos = Player.position
