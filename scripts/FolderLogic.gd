extends Node2D

@onready var window = $Window

@export var isInArea := false
@export var startOpen := false
@export var fullOpen := false
@export var value := 30
var openProgress := 0.9

func _ready():
	pass 
	
func _process(delta):
	if !startOpen && isInArea:
		if Input.is_action_pressed("Space"):
			startOpen = true
			openProgress = 0.0
		return
		
	if fullOpen && isInArea:
		if Input.is_action_pressed("Space"):
			queue_free()
		return
	
	if startOpen and !fullOpen:
		openProgress += delta*2
		openProgress = min(openProgress, 1)
		window.scale = Vector2(openProgress, openProgress)
		if openProgress >= 1:
			fullOpen = true
			spawnStuff()
		

func _on_open_zone_area_entered(area):
	isInArea = true

func _on_open_zone_area_exited(area):
	isInArea = false
	
	
func spawnStuff():
	var exp_count:int = int(randi() % 30) + 10
	var expObject = load("res://objects/exp.tscn")
	for i in exp_count:
		var exp = expObject.instantiate()
		exp.value = value/exp_count
		exp.position = position + Vector2(randi()%400-200,randi()%400-200)
		exp.apply_force(Vector2(randi()%30000-15000,randi()%30000-15000))
		get_tree().get_root().add_child(exp)
	
	var rand = randi()%3
	if rand == 2:
		var obj = load("res://objects/exp.tscn").instantiate()
		obj.position = position
		get_tree().get_root().add_child(obj)
		
