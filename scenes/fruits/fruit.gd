class_name RegularFruit
extends Node2D


@export var id: int = -1
@export var steps: int = 1
@onready var _field: FieldManager = get_tree().get_first_node_in_group("Field")


func _ready() -> void:
	assert(id != -1, "id was not set for fruits")
	_field.registry_fruits[_field.local_to_map(position)] = self


func push(player_pos: Vector2i, pos: Vector2i) -> void:
	var dir: Vector2i = pos - player_pos
	var end: Vector2i = _move(pos, dir)
	if pos == end: return # haven't moved

	_field.registry_fruits.erase(pos)

	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", _field.map_to_local(end), Global.MOVE_TIME)
	
	tween.tween_callback(func()->void:
		_field.registry_fruits[end] = self
	)


func _move(pos: Vector2i, dir: Vector2i) -> Vector2i:
	var remains: int = steps
	while remains != 0:
		pos += dir
		if Global.out_of_range(pos): return pos - dir # field bounds collision
		if _field.get_cell_source_id(pos) != -1: return pos - dir # object collision
		remains -= 1
	return pos
