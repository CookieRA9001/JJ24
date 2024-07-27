extends Node2D

@export var speed := 20.0
@onready var hurt_box = $Shield/HurtBox
@onready var static_body_2d = $Shield/StaticBody2D

func _ready():
	visible = false
	static_body_2d.set_process(false)
	hurt_box.set_process(false)
	set_process(false)

func _process(delta):
	rotation_degrees += delta*speed

func turnOn():
	visible = true
	static_body_2d.set_process(true)
	hurt_box.set_process(true)
	set_process(true)
	
