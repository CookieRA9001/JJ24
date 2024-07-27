extends CharacterBody2D

@onready var body = $Body
@onready var base_body = $Body/Body

enum TYPES {VIRUS, TROJAN, WORM, WORM_PART}

@export var speed = 250.0
@export var damage = 2
@export var maxHealth := 3.0
@export var health := maxHealth
@export var value := 5.0
@export var GM: Node
@export var enemyType = TYPES.VIRUS
@export var target:Vector2
@export var spawnCount:int = 0

var damageTimer: Timer

func _ready():
	health = maxHealth
	damageTimer = Timer.new()
	add_child(damageTimer)
	damageTimer.one_shot = true
	damageTimer.wait_time = 0.2
	damageTimer.connect("timeout", undamage)

func _physics_process(delta):
	match enemyType:
		TYPES.VIRUS:
			if GM.PlayerPos != null:
				target = GM.PlayerPos
		TYPES.TROJAN:
			pass

	velocity = (target - position).normalized() * speed
		
	if velocity.x > 0:
		body.scale.x = -1
	else:
		body.scale.x = 1
				
	move_and_slide()
	
func updateHealth(delta):
	health += delta
	
	if health<=0:
		GM.find_child("AudioManager")._on_enemy_play_die()
		var exp_count:int = int(randi() % 5) + 2
		var expObject = load("res://objects/exp.tscn")
		for i in exp_count:
			var exp = expObject.instantiate()
			exp.value = value/float(exp_count)
			exp.apply_force(Vector2(randi()%15000-7500,randi()%15000-7500))
			exp.position = position
			get_tree().get_root().add_child(exp)
			
		queue_free()
		return
	
	if delta<0:
		GM.find_child("AudioManager")._on_enemy_play_hit()
		print("ping")
		base_body.visible = false
		damageTimer.start()
		
func undamage() -> void:
	base_body.visible = true

func _on_trojen_move_timeout():
	target = position + Vector2(randi()%1000 - 500, randi()%1000 - 500)
	
func _on_spawn_enemies_timeout():
	var obj = load("res://objects/enemy_weak.tscn")
	for i in spawnCount:
		var o = obj.instantiate()
		o.position = position + Vector2(randi()%400-200, randi()%400-200)
		o.GM = GM
		get_tree().get_root().add_child(o)
