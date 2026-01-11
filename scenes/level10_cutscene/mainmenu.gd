extends TextureButton


func _ready() -> void:
	pressed.connect(func()->void: Transition.change_scene(load("res://ui/main_menu/main_menu.tscn")))
