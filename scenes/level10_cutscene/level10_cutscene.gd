extends Control


func _ready() -> void:
	$AudioStreamPlayer.finished.connect(func()->void:
		$VideoStreamPlayer.visible = true
		$VideoStreamPlayer.play()
	)
	$VideoStreamPlayer.finished.connect(func()->void:
		Transition.change_scene(load("res://scenes/levels/level_10_2.tscn"))
	)
