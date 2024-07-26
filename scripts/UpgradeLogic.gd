extends RigidBody2D

@export var Target: CharacterBody2D
@export var speed := 200
@onready var sprite_2d = $Sprite2D

func _physics_process(delta):
	if Target == null:
		return
	
	linear_velocity = (Target.position - position).normalized() * speed

func _on_body_entered(body):
	if "xp" in body:
		body.upgrade()
		queue_free()
