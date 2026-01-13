extends TextureButton


func _on_new_game_pressed() -> void:
	Transition.change_scene(load("res://ui/intro/intro.tscn"))
