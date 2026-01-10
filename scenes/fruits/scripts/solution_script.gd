class_name Solution
extends Node2D


@export var id: int = -1


func _ready() -> void:
	assert(id != -1, "id was not set for solution")
	var _solution: SolutionManager = get_tree().get_first_node_in_group("Solution")
	var pos: Vector2i = _solution.local_to_map(position)
	_solution.registry[pos] = id
