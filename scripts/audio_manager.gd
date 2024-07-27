extends Node


func play_music(music):
	$music_player.stream = music
	$music_player.play ()
	
func play_effect(clip):
	clip.play()
	
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_player_play_shoot():
	play_effect($Effects_player/effect_player_1)

func _on_player_play_ding():
	play_effect($Effects_player/effect_player_2)

func _on_player_play_lvl():
	play_effect($Effects_player/effect_player_4)


func _on_player_play_hurt():
	play_effect($Effects_player/effect_player_5)


func _on_enemy_play_hit():
	play_effect($Effects_player/effect_player_3)


func _on_enemy_play_die():
	play_effect($Effects_player/effect_player_6)


func _on_player_play_rip():
	play_effect($Effects_player/effect_player_7)


func _on_upgrade_menu_play_click():
	play_effect($Effects_player/effect_player_8)
