extends CharacterBody2D

@onready var camera_2d = $Camera
@onready var health_bar = $HealthBar
@onready var xp_bar = $XPBar
@onready var aim = $Aim
@onready var body = $Body
@onready var shoot_time = $Aim/ShootTime
@onready var upgrade_menu:Panel = $"../CanvasLayer/UpgradeMenu"
@onready var fire_wall_timer = $UpgradeStuff/FireWallTimer
@onready var defender = $Defender
@onready var defender_hurt_box = $Defender/Shield/HurtBox

@export var maxHealth := 10.0
@export var health := maxHealth
@export var damage := 1.0
@export var xp := 0.0
@export var level := 1
@export var nextLevel := 10.0
@export var speed: float = 350.0
@export var firewallLevel: int = 0
@export var defenderLevel: int = 0
@export var tmpLevel: int = 0

signal play_shoot
signal play_ding
signal play_lvl
signal play_hurt
signal play_rip

func _ready():
	health = maxHealth
	upgrade_menu.visible = false
	updateHealth(0)

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
		bullet.setPierce(1 + tmpLevel)
		shoot_time.start()
		play_shoot.emit()
		
	addXP(0)
	
func updateHealth(delta):
	health += delta
	health_bar.scale.x = health/maxHealth * 4
	
	if delta<0:
		play_hurt.emit()
	
	if health<=0:
		play_rip.emit()
		queue_free()

func _on_exp_collector_body_entered(body):
	body.Target = self
	
func addXP(delta:float):
	if delta>0.0:
		play_ding.emit()
	xp += delta
	xp_bar.scale.x = min(xp/nextLevel * 4,4)
	# level up
	if xp >= nextLevel:
		levelUp()
		
func levelUp():
	play_lvl.emit()
	xp -= nextLevel
	level += 1
	nextLevel *= 1.25
	
	damage += 0.1
	maxHealth += 1
	health = maxHealth
	speed += 10
	shoot_time.wait_time = 0.5 / (0.98 + 0.02*level)
	updateHealth(0)
	
	upgrade()

func upgrade():
	upgrade_menu.rollUpgrades()

func intiFireWall():
	fire_wall_timer.start()

func defenderLevelUp():
	if defenderLevel == 0:
		defender.set_process(true)
		defender.visible = true
	defender.speed += 5
	defender_hurt_box.Damage += 0.2
	defender_hurt_box.scale = Vector2(1+defenderLevel*0.1,1+defenderLevel*0.1)
	defenderLevel += 1

func _on_fire_wall_timer_timeout():
	var firewall = load("res://objects/fire_wall.tscn").instantiate()
	get_tree().get_root().add_child(firewall)
	var lookDir = (get_global_mouse_position()-global_position).normalized()
	firewall.global_position = global_position + lookDir*400
	firewall.level = firewallLevel
	firewall.rotation = get_angle_to(get_global_mouse_position())
	fire_wall_timer.start()
