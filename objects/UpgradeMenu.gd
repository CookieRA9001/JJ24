extends Panel

@onready var texture_rect1 = $TextureRect/Panel/TextureRect
@onready var rich_text_label1 = $TextureRect/Panel/RichTextLabel
@onready var texture_rect2 = $TextureRect/Panel2/TextureRect
@onready var rich_text_label2 = $TextureRect/Panel2/RichTextLabel
@onready var texture_rect3 = $TextureRect/Panel3/TextureRect
@onready var rich_text_label3 = $TextureRect/Panel3/RichTextLabel


@export var upgrades = [
	{
		"id": "firewall",
		"description": "[center][wave]Firewall[/wave]\nSpawn a wall of fire in front of the player that blocks and damages enemies.",
		"image": null
	},
	{
		"id": "defender",
		"description": "[center][wave]Defender[/wave]\n-",
		"image": null
	},
	{
		"id": "tmp",
		"description": "[center][wave]TMP Chip[/wave]\n-",
		"image": null
	},
	{
		"id": "encryption",
		"description": "[center][wave]Encryption[/wave]\n-",
		"image": null
	},
	{
		"id": "passwords",
		"description": "[center][wave]Password Locks[/wave]\n-",
		"image": null
	}
]

var items = [null, null, null]

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
	match items[i].id:
		"firewall": pass
		"defender": pass
		"tmp": pass
		"encryption": pass
		"passwords": pass
	visible = false
	get_tree().paused = false

func _on_button_0_pressed():
	buyItem(0)
func _on_button_1_pressed():
	buyItem(1)
func _on_button_2_pressed():
	buyItem(2)
