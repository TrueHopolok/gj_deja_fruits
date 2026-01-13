extends TextureButton


func _ready() -> void:
	disabled = Persistance.unlocked_level == 1


func _on_pressed() -> void:
	Transition.change_scene(
		load("res://scenes/levels/main/level_%d.tscn" % clampi(Persistance.unlocked_level, 1, 10))
	)
