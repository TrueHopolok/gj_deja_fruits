extends Node2D


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")



func _on_audio_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/audio_settings/audio_settings.tscn")
