extends Control


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		visible = get_tree().paused


func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	visible = false
