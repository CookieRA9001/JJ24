extends RigidBody2D

@export var Target: CharacterBody2D
@export var speed := 200
@export var value := 1.0
@export var altTex: Texture2D
@onready var sprite_2d = $Sprite2D

func _ready():
	if bool(randi() % 2):
		sprite_2d.texture = altTex

func _physics_process(delta):
	if Target == null:
		return
	
	linear_velocity = (Target.position - position).normalized() * speed

func _on_body_entered(body):
	body.xp += value
	queue_free()
