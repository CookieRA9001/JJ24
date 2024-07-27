extends Node2D

@onready var rich_text_label = $CanvasLayer/RichTextLabel

@export var PlayerPos: Vector2 = Vector2(0,0)
@export var Player: CharacterBody2D
@onready var spawn_timer = $SpawnTimer
@export var Level = 0
@export var Round = 0
@export var TimePassed = 0

@export var Waves = [
	[
		{
			"time": 6, # 6
			"enemies": [5, "virus"]
		},
		{
			"time": 9, #15
			"enemies": [10, "virus"]
		},
		{
			"time": 11, #26
			"enemies": [10, "virus", 1, "trojen"]
		},
		{
			"time": 10, #36
			"enemies": [10, "virus2", 1, "folder"]
		},
		{
			"time": 14, #50
			"enemies": [20, "virus", 10, "virus2"]
		},
		{
			"time": 30, # 1 20
			"enemies": [10, "ads", 10, "virus", 5, "trojen"]
		},
		{
			"time": 10, # 1 30
			"enemies": [10, "ads", 10, "virus", 1, "folder"]
		},
		{
			"time": 30, # 2 00
			"enemies": [10, "spike", 2, "folder"]
		},
		{
			"time": 15, # 2 15
			"enemies": [20, "trojen", 1, "folder2"]
		},
		{
			"time": 20, # 2 35
			"enemies": [5, "virus3", 20, "virus", 10, "spike"]
		},
		{
			"time": 10, # 2 45
			"enemies": [3, "trojen2", 10, "virus2"]
		},
		{
			"time": 30, # 3 15
			"enemies": [5, "ads2", 20, "virus2", 10, "trojen", 1, "folder2"]
		},
		{
			"time": 30, # 3 45
			"enemies": [10, "ads2", 10, "virus3", 15, "trojen", 2, "folder2"]
		},
		{
			"time": 20, # 4 05
			"enemies": [20, "ads", 20, "virus", 10, "trojen", 4, "folder"]
		},
		{
			"time": 10, # 4 15
			"enemies": [5, "virus4", 5, "trojen2", 20, "ads2"]
		},
		{
			"time": 20, # 4 35
			"enemies": [20, "virus4"]
		},
		{
			"time": 30, # 5 05
			"enemies": [30, "virus4"]
		},
		{
			"time": 20, # 5 25
			"enemies": [10, "spike2", 20, "spike", 3, "folder2"]
		},
		{
			"time": 20, # 5 45
			"enemies": [10, "trojen2"]
		} ,
		{
			"time": 25, # 6 10
			"enemies": [10, "spike2", 20, "virus4", 20, "ads2"]
		} ,
		{
			"time": 20, # 6 30
			"enemies": [30, "spike2"]
		} ,
		{
			"time": 30, # 7 00
			"enemies": [30, "virus4"]
		},
		{
			"time": 20, # 7 20
			"enemies": [20, "trojen2"]
		},
		{
			"time": 20, # 7 40
			"enemies": [5, "spike2", 1, "folder3"]
		},
		{
			"time": 20, # 8 00
			"enemies": [10, "spike2", 3, "folder2"]
		},
		{
			"time": 20, # 8 00
			"enemies": [10, "virus4", 10, "ads2", 10, "trojen2", 20, "virus3"]
		},
		{
			"time": 30, # 8 30
			"enemies": [15, "virus4", 25, "virus3"]
		},
		{
			"time": 30, # 9 00
			"enemies": [10, "virus5"]
		},
		{
			"time": 20, # 9 20
			"enemies": [10, "virus5", 10, "trojen2"]
		},
		{
			"time": 20, # 9 40
			"enemies": [20, "virus5", 10, "spike2", 10, "ads2", 3, "folder3"]
		},
		{
			"time": 20, # 10 00
			"enemies": [20, "virus5", 20, "trojen3"]
		}
	]
]

func _ready():
	pass

func _process(delta):
	if Player != null:
		PlayerPos = Player.position
		TimePassed += delta
	rich_text_label.text = ("[center]" if TimePassed >= 600 else "[center]0") + str(int(TimePassed/60)) + ":" + ("" if int(TimePassed)%60 >= 10 else "0") + str(int(TimePassed) % 60)

func _on_spawn_timer_timeout():
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
			"virus2":
				enemy = load("res://objects/enemy_2.tscn")
			"virus3":
				enemy = load("res://objects/enemy_3.tscn")
			"virus4":
				enemy = load("res://objects/enemy_4.tscn")
			"virus5":
				enemy = load("res://objects/enemy_5.tscn")
			"ads":
				enemy = load("res://objects/enemy_add.tscn")
			"ads2":
				enemy = load("res://objects/enemy_add_2.tscn")
			"spike":
				enemy = load("res://objects/enemy_worm.tscn")
			"spike2":
				enemy = load("res://objects/enemy_worm_2.tscn")
			"trojen":
				enemy = load("res://objects/enemy_trojan.tscn")
			"trojen2":
				enemy = load("res://objects/enemy_trojan_2.tscn")
			"trojen3":
				enemy = load("res://objects/enemy_trojan_3.tscn")
			"folder":
				enemy = load("res://objects/folder.tscn")
			"folder2":
				enemy = load("res://objects/folder2.tscn")
			"folder3":
				enemy = load("res://objects/folder3.tscn")
			"end":
				enemy = load("res://objects/enemy.tscn") # :P
		
		for j in enemyCount:
			var mob = enemy.instantiate()
			mob.global_position = get_random_position()
			if "GM" in mob:
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
