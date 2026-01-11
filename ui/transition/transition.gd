extends Node


@onready var ts: AnimatedSprite2D = $TransitionSprite


func fade_in() -> void:
	ts.play("fade_in")
	await ts.animation_finished


func fade_out() -> void:
	ts.play("fade_out")
	await ts.animation_finished


func change_scene(scene: PackedScene) -> void:
	await fade_in()
	get_tree().change_scene_to_packed(scene)
	await fade_out()
	get_tree().paused = false


func reload_scene() -> void:
	await fade_in()
	get_tree().reload_current_scene()
	await fade_out()
	get_tree().paused = false
