class_name Fruit
extends Node2D


@onready var _field: FieldManager = get_tree().get_first_node_in_group("Field")


func _ready() -> void:
	_field.set_cell(_field.local_to_map(position), -1)
	_field.registry_fruits[_field.local_to_map(position)] = self
