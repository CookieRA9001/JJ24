extends Node2D

@export var PlayerPos: Vector2 = Vector2(0,0)
@export var Player: CharacterBody2D
@onready var spawn_timer = $SpawnTimer
@export var Level = 0
@export var Round = 0

@export var Waves = [
	[
		{
			"time": 10,
			"enemies": [5, "virus"]
		},
		{
			"time": 10,
			"enemies": [10, "virus"]
		},
		{
			"time": 20,
			"enemies": [15, "virus"]
		},
		{
			"time": 30,
			"enemies": [20, "virus"]
		},
		{
			"time": 10,
			"enemies": [30, "virus"]
		},
		{
			"time": 0,
			"enemies": [1, "end"]
		}
	]
]

func _ready():
	pass

func _process(delta):
	if Player != null:
		PlayerPos = Player.position


func _on_spawn_timer_timeout():
	print("ping")
	var wave = Waves[Level][Round]
	
	if wave.time!=0:
		spawn_timer.wait_time = wave.time
		spawn_timer.start()
		Round += 1
	
	for i in range(0,wave.enemies.size(),2):
		var enemy = wave.enemies[i+1]
		var enemyCount = wave.enemies[i]
		
		match enemy:
			"virus":
				enemy = load("res://objects/enemy.tscn")
			"end":
				enemy = load("res://objects/enemy.tscn") # :P
		
		for j in enemyCount:
			var mob = enemy.instantiate()
			mob.global_position = get_random_position()
			mob.GM = self
			add_child(mob)
	

# https://github.com/brannotaylor/SurvivorsClone_Complete/blob/main/Utility/enemy_spawner.gd
func get_random_position():
	var vpr = get_viewport_rect().size * randf_range(2,2.5)
	var top_left = Vector2(PlayerPos.x - vpr.x/2, PlayerPos.y - vpr.y/2)
	var top_right = Vector2(PlayerPos.x + vpr.x/2, PlayerPos.y - vpr.y/2)
	var bottom_left = Vector2(PlayerPos.x - vpr.x/2, PlayerPos.y + vpr.y/2)
	var bottom_right = Vector2(PlayerPos.x + vpr.x/2, PlayerPos.y + vpr.y/2)
	var pos_side = ["up","down","right","left"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match pos_side:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
	
	var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y,spawn_pos2.y)
	return Vector2(x_spawn,y_spawn)
