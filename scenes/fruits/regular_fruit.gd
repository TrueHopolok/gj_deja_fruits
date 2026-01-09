class_name RegularFruit
extends Fruit


@export var steps: int = 1
@onready var _player: Player = get_tree().get_first_node_in_group("Player")


func _ready() -> void:
	super() 


func push(player_pos: Vector2i, pos: Vector2i) -> void:
	var dir: Vector2i = pos - player_pos
	var end: Vector2i = _move(pos, dir)
	if pos == end: return # haven't moved

	_player.forward_block = true
	_field.registry_fruits.erase(pos)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", _field.map_to_local(end), Global.MOVE_TIME)
	tween.tween_callback(func()->void:
		_field.registry_fruits[end] = self
		_player.forward_block = false
	)


func _move(pos: Vector2i, dir: Vector2i) -> Vector2i:
	var remains: int = steps
	var next: Vector2i
	while remains != 0:
		next = pos + dir
		if _field.out_of_range(next): return pos
		if _field.get_cell_source_id(next) != -1: return pos
		if _field.registry_fruits.has(next): return pos
		if _field.registry_ded == next: return pos
		pos = next
		remains -= 1
	return pos
