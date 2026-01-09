class_name Pineapple
extends RegularFruit


func follow(end: Vector2i) -> void:
	var pos: Vector2i = _field.local_to_map(position)
	_field.registry_fruits.erase(pos)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", _field.map_to_local(end), Global.MOVE_TIME)
	tween.tween_callback(func()->void:
		_field.registry_fruits[end] = self
	)
