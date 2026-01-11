extends Node2D


func _on_video_stream_player_finished() -> void:
	Transition.change_scene(load("res://scenes/levels/level_1.tscn"))
