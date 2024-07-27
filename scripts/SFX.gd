extends Node

func play_effect(clip):
	clip.play()

func _on_enemy_play_die():
	play_effect($death_sfx)

func _on_enemy_play_hit():
	play_effect($hit_sfx)
