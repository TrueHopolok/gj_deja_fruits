class_name Fruit
extends Node2D


@export var id: int = -1
@onready var _field: FieldManager = get_tree().get_first_node_in_group("Field")


func _ready() -> void:
	assert(id != -1, "id was not set for fruit")
	var pos: Vector2i = _field.local_to_map(position)
	_field.set_cell(pos, -1)
	_field.registry_fruits[pos] = self
