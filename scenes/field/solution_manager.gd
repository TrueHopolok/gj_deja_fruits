class_name SolutionManager
extends TileMapLayer


@onready var _textbox: Textbox = get_tree().get_first_node_in_group("Textbox")

## All fruits on final positions and their id <Vector2i, int>
var registry: Dictionary = {}


func _process(_delta: float) -> void:
	visible = Input.is_action_pressed(&"deja_vu") && (!_textbox.active)


func solved() -> bool:
	var field: FieldManager = get_tree().get_first_node_in_group("Field")
	for pos in registry:
		if !field.registry_fruits.has(pos): return false
		var id: int = registry[pos]
		if id != field.registry_fruits[pos].id: return false
	return true
