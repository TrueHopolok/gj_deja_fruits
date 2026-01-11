extends Node

func transition():
	await get_tree().create_timer(3.0).timeout
	Transition.change_scene(load("res://ui/main_menu/main_menu.tscn"))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("skip_dialog"):
		Transition.change_scene(load("res://ui/main_menu/main_menu.tscn"))
