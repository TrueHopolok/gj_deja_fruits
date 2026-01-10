class_name DragonFruit
extends Fruit


const _directions: Array[Vector2i] = [Vector2i.DOWN, Vector2i.UP, Vector2i.LEFT, Vector2i.RIGHT]

@onready var _danger: PackedScene = preload('res://scenes/fruits/regular/danger_zone.tscn')


func _ready() -> void:
	super()
	var pos: Vector2i = _field.local_to_map(position)
	for dir in _directions:
		var instance: Node2D = _danger.instantiate()
		get_parent().add_child(instance)
		var end: Vector2i = pos + dir
		instance.position = _field.map_to_local(end)
		_field.registry_danger[end] = true
