class_name Fruit
extends Node2D


@export var id: int = -1
@onready var _field: FieldManager = get_tree().get_first_node_in_group("Field")


func _ready() -> void:
	assert(id != -1, "id was not set for fruits")
	_field.registry_fruits[_field.local_to_map(position)] = self


func push(player_pos: Vector2i, pos: Vector2i) -> void:
	var dir: Vector2i = pos - player_pos
	var end: Vector2i = _move(pos, dir)
	if pos == end: return # haven't moved

	_field.set_cell(pos, -1)
	_field.registry_fruits.erase(pos)

	_field.set_cell(end, self.id)
	_field.registry_fruits[end] = self

	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", _field.map_to_local(end), Global.MOVE_TIME)


func _move(pos: Vector2i, dir: Vector2i) -> Vector2i:
	# This is a movement of a pear
	# TODO: other movements
	var target: Vector2i = pos + dir
	#if Global.out_of_range(target): return pos # field bounds collision
	if _field.get_cell_source_id(target) != -1: return pos # object collision
	return target
