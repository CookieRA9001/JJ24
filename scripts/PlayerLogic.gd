extends CharacterBody2D

@onready var camera_2d = $Camera2D
@onready var health_bar = $HealthBar
@onready var xp_bar = $XPBar
@onready var aim = $Aim
@onready var body = $Body
@onready var shoot_time = $Aim/ShootTime

@export var maxHealth := 10.0
@export var health := maxHealth
@export var damage := 1.0
@export var xp := 0.0
@export var level := 1
@export var nextLevel := 10.0
@export var speed: float = 300.0

func _ready():
	health = 1
	updateHealth(maxHealth)

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("Left", "Right"),Input.get_axis("Up", "Down")).normalized()
	
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
		
	if velocity.x > 0:
		body.scale.x = -1
	else:
		body.scale.x = 1

	move_and_slide()

func _process(delta):
	aim.rotation = get_angle_to(get_global_mouse_position())
	
	if Input.is_action_pressed("Click") and shoot_time.is_stopped():
		var bullet = load("res://objects/player_bullet.tscn").instantiate()
		get_tree().get_root().add_child(bullet)
		bullet.init(position, damage, (get_global_mouse_position()-global_position).normalized(), 40000)
		shoot_time.start()
	
	# exp
	xp_bar.scale.x = min(xp/nextLevel * 4,4)
	# level up
	if xp >= nextLevel:
		levelUp()
		
	
func updateHealth(delta):
	health += delta
	health_bar.scale.x = health/maxHealth * 4
	
	if health<=0:
		queue_free()

func _on_exp_collector_body_entered(body):
	body.Target = self
	
func levelUp():
	xp -= nextLevel
	level += 1
	nextLevel *= 1.25
	
	damage += 0.1
	maxHealth += 1
	health = maxHealth
	speed += 10
	shoot_time.wait_time = 0.5 / (0.98 + 0.02*level)
	
