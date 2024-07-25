extends CharacterBody2D

const SPEED: float = 300.0
@onready var camera_2d = $Camera2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var health_bar = $HealthBar

@export var maxHealth := 10.0
@export var health := maxHealth
@export var isHit = false

func _ready():
	health = 1
	updateHealth(maxHealth)

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("Left", "Right"),Input.get_axis("Up", "Down")).normalized()
	
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	animated_sprite_2d.flip_h = velocity.x > 0

	move_and_slide()
	
func updateHealth(delta):
	health += delta
	health_bar.scale.x = health/maxHealth * 4
	
	if health<=0:
		queue_free()
