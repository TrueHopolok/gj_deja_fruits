extends TextureButton


func _ready() -> void:
	disabled = Persistance.unlocked_level == 1
	pressed.connect(_pressed)


func _pressed() -> void:
	Transition.change_scene(
		load("res://scenes/levels/main/level_%d.tscn" % clampi(Persistance.unlocked_level, 1, 10))
	)
