extends Node


func fade_in() -> void:
	%TransitionSprite.play("fade_in")


func fade_out() -> void:
	%TransitionSprite.play("fade_out")


func change_scene(path: String) -> void:
	%TransitionSprite.play("fade_in")
	get_tree().change_scene_to_file(path)
	%TransitionSprite.play("fade_out")
