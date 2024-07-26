extends Area2D

@export var Damage: = 1.0
@export var DamageTime: = 0.5
@export var DeathTime: = 100000
@export var Pierce := -1
@onready var timer = $Timer
@onready var hurt_box = $HurtBox
@onready var death_time = $DeathTime
var root

var inArea = []

func _ready():
	timer.wait_time = DamageTime
	death_time.wait_time = DeathTime
	death_time.start()
	root = get_parent()

func _process(delta):
	if !timer.is_stopped() or inArea.size() == 0:
		return
		
	for index in inArea.size():
		var body = inArea[index]
		body.updateHealth(-Damage)
		
	if Pierce > 0:
		Pierce -= 1
		if Pierce == 0:
			root.queue_free()
			return
	
	timer.start()

func _on_area_entered(area):
	if "health" in area.get_parent() and not area.get_parent() in inArea:
		inArea.append(area.get_parent())

func _on_area_exited(area):
	if "health" in area.get_parent() and area.get_parent() in inArea:
		inArea.remove_at(inArea.find(area.get_parent()))


func _on_death_time_timeout():
	root.queue_free()
