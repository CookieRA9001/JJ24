extends Node2D

@onready var death_timer = $DeathTimer
@onready var hurt_box = $HurtBox

@export var level = 1

func _ready():
	scale *= 0.9+(0.1*level)
	death_timer.wait_time = 4.6 + (0.4*level)
	hurt_box.Damage = 1 + 0.1*level
	hurt_box.DamageTime = 1/(0.8 + 0.2*level)

func _on_death_timer_timeout():
	queue_free()
