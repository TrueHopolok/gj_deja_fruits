extends Node2D


func _on_video_stream_player_finished() -> void:
	Transition.change_scene(load("res://scenes/levels/main/level_1.tscn"))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("skip_dialog"):
		Transition.change_scene(load("res://scenes/levels/main/level_1.tscn"))
