extends Node2D


@onready var _field: FieldManager = get_tree().get_first_node_in_group("Field")


func _ready() -> void:
	var pos: Vector2i = _field.local_to_map(position)
	_field.set_cell(pos, -1)
	_field.registry_danger[pos] = true
