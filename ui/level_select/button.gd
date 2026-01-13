extends TextureButton


func _ready() -> void:
	var lvl_num: int = int($Label.text)
	pressed.connect(func() -> void:
		Transition.change_scene(load("res://scenes/levels/main/level_%d.tscn" % lvl_num))
	)
	disabled = Persistance.unlocked_level < lvl_num || Persistance.unlocked_level == 1
