extends CharacterBody2D

@onready var body = $Body

@export var speed = 250.0
@export var damage = 2
@export var maxHealth := 3.0
@export var health := maxHealth
@export var value := 5
@export var GM: Node

func _ready():
	health = maxHealth

func _physics_process(delta):
	if GM.PlayerPos != null:
		velocity = (GM.PlayerPos - position).normalized() * speed
		
	if velocity.x > 0:
		body.scale.x = -1
	else:
		body.scale.x = 1
		
	move_and_slide()
	
func updateHealth(delta):
	health += delta
	
	if health<=0:
		var exp_count:int = int(randi() % 5) + 2
		var expObject = load("res://objects/exp.tscn")
		for i in exp_count:
			var exp = expObject.instantiate()
			exp.value = value/exp_count
			exp.apply_force(Vector2(randi()%15000-7500,randi()%15000-7500))
			exp.position = position
			get_tree().get_root().add_child(exp)
			
		queue_free()
