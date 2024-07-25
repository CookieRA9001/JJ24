extends CharacterBody2D

const SPEED: float = 300.0
@onready var camera_2d = $Camera2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var health_bar = $HealthBar
@onready var aim = $Aim

@export var maxHealth := 10.0
@export var health := maxHealth
@export var damage := 1.0

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

func _process(delta):
	aim.rotation = get_angle_to(get_global_mouse_position())
	if Input.is_action_pressed("Click"):
		var bullet = load("res://objects/player_bullet.tscn").instantiate()
		add_child(bullet)
		bullet.init(damage, (get_global_mouse_position()-global_position).normalized(), 40000)
		
	
func updateHealth(delta):
	health += delta
	health_bar.scale.x = health/maxHealth * 4
	
	if health<=0:
		queue_free()
