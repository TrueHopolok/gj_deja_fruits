extends Control


func _on_level_select_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/level_select/level_select.tscn")


func _on_audio_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/audio_settings/audio_settings.tscn")


func _on_new_game_pressed() -> void:
	Transition.change_scene(load("res://ui/intro/intro.tscn"))
