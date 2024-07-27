extends Panel

@onready var texture_rect1 = $TextureRect/Panel/TextureRect
@onready var rich_text_label1 = $TextureRect/Panel/RichTextLabel
@onready var texture_rect2 = $TextureRect/Panel2/TextureRect
@onready var rich_text_label2 = $TextureRect/Panel2/RichTextLabel
@onready var texture_rect3 = $TextureRect/Panel3/TextureRect
@onready var rich_text_label3 = $TextureRect/Panel3/RichTextLabel
@onready var player = $"../../Player"

signal play_click

@export var upgrades = [
	{
		"id": "firewall",
		"description": "[center][wave]Firewall[/wave]\nSpawn a wall of fire in front of the player that blocks and damages enemies.",
		"image": null
	},
	{
		"id": "defender",
		"description": "[center][wave]Defender[/wave]\nGenerate a shield that circles the player and damages enemies. Increase size, speed and damage with levels.",
		"image": null
	},
	{
		"id": "tmp",
		"description": "[center][wave]TMP Chip[/wave]\nYour bullets gain piercing, pierce an additional enemy with each level.",
		"image": null
	},
	{
		"id": "encryption",
		"description": "[center][wave]Encryption[/wave]\nIncrease your bullet damage.",
		"image": null
	},
	{
		"id": "passwords",
		"description": "[center][wave]Password Locks[/wave]\nIncreases your max HP (+10%)",
		"image": null
	},
	{
		"id": "raider",
		"description": "[center][wave]Data Scan[/wave]\nIncrease your bit collection radius.",
		"image": null
	},
	{
		"id": "virtualization",
		"description": "[center][wave]Virtualization[/wave]\nIncrease your movement speed.",
		"image": null
	},
	{
		"id": "fingerprint",
		"description": "[center][wave]Virtualization[/wave]\nKill all spawned enemies.",
		"image": null
	}
]

var items = [null, null, null]

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func rollUpgrades():
	for i in 3:
		items[i] = upgrades[int(randi()%upgrades.size())]
	
	texture_rect1.texture = items[0].image
	rich_text_label1.text = items[0].description
	texture_rect2.texture = items[1].image
	rich_text_label2.text = items[1].description
	texture_rect3.texture = items[2].image
	rich_text_label3.text = items[2].description
	
	visible = true
	get_tree().paused = true
	
func buyItem(i):
	play_click.emit()
	match items[i].id:
		"firewall": 
			if player.firewallLevel == 0:
				player.intiFireWall()
			player.firewallLevel += 1
		"defender":
			player.defenderLevelUp()
		"tmp": 
			player.tmpLevel += 1
		"encryption":
			player.damage += 1
		"passwords":
			var h = player.maxHealth*0.1
			player.maxHealth += h
			player.updateHealth(h)
		"raider":
			player.incExpCollection()
		"virtualization":
			player.speed += 50
		"fingerprint":
			killAll()
	visible = false
	get_tree().paused = false

func _on_button_0_pressed():
	buyItem(0)
func _on_button_1_pressed():
	buyItem(1)
func _on_button_2_pressed():
	buyItem(2)
	
func killAll():
	for member in get_tree().get_nodes_in_group("enemy"):
		member.updateHealth(-1-player.level)
