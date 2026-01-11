extends TextureButton


func _ready() -> void:
	pressed.connect(func() -> void:
		Transition.change_scene(load("res://scenes/levels/level_%s.tscn" % $Label.text))
	)
