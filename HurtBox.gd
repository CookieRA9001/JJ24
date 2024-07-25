extends Area2D

@export var Damage: = 1.0
@export var DamageTime: = 0.5
@export var Size: = 1.0
@onready var timer = $Timer
@onready var hurt_box = $HurtBox

var inArea = []

func _ready():
	timer.wait_time = DamageTime

func _process(delta):
	if !timer.is_stopped():
		return
		
	for index in inArea.size():
		var body = inArea[index]
		body.updateHealth(-Damage)
	
	timer.start()

func _on_area_entered(area):
		
	if "health" in area.get_parent() and not area.get_parent() in inArea:
		print("touch")
		inArea.append(area.get_parent())

func _on_area_exited(area):
	if "health" in area.get_parent() and area.get_parent() in inArea:
		print("untouch")
		inArea.remove_at(inArea.find(area.get_parent()))
