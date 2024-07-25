extends CharacterBody2D

@onready var sprite_2d = $Sprite2D

@export var Speed = 250.0
@export var Damage = 2
@export var MaxHealth := 3.0
@export var Health := MaxHealth
@export var GM: Node

func _ready():
	Health = MaxHealth

func _physics_process(delta):
	if GM.PlayerPos != null:
		velocity = (GM.PlayerPos - position).normalized() * Speed
	sprite_2d.flip_h = velocity.x > 0
	move_and_slide()
	
func updateHealth(delta):
	Health += delta
	
	if Health<=0:
		queue_free()
