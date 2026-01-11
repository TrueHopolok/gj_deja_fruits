extends Control


func _ready() -> void:
	$AudioStreamPlayer.finished.connect(func()->void:
		assert(false, "FROGET TO SET A FINAL SCENE")
		Transition.change_scene(load(""))
	)
