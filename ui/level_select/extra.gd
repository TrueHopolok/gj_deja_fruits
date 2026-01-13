extends TextureButton


@export var level_to_load: PackedScene


func _ready() -> void:
	pressed.connect(_pressed)


func _pressed() -> void:
	Transition.change_scene(level_to_load)
