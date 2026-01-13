extends TextureButton


func _ready() -> void:
	pressed.connect(_pressed)


func _pressed() -> void:
	Persistance.complete(11)
	Transition.change_scene(load("res://ui/main_menu/main_menu.tscn"))
