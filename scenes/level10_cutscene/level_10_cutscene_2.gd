extends Control


func _ready() -> void:
	$AudioStreamPlayer.finished.connect(func()->void:
		Transition.change_scene(load("res://scenes/level10_cutscene/thank_for_playing.tscn"))
	)
