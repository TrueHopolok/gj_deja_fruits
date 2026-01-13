extends TextureButton


func _ready() -> void:
	pressed.connect(_pressed)


func _pressed() -> void:
	# TODO: add confirmation?
	Persistance.reset()
	Transition.change_scene(load("res://ui/main_menu/main_menu.tscn"))
