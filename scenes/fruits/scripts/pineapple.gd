class_name Pineapple
extends RegularFruit


const PINEAPPLE_BLOCK = 'pineapple_block'


func follow(player: Player) -> void:
	_audio.stream = AUDIO_STREAM[randi() % AUDIO_LENGTH]
	_audio.play()
	player.block[PINEAPPLE_BLOCK] = true
	var pos: Vector2i = _field.local_to_map(position)
	var end: Vector2i = _field.local_to_map(player.position)
	_field.registry_fruits.erase(pos)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", _field.map_to_local(end), Global.MOVE_TIME)
	tween.tween_callback(func()->void:
		_field.registry_fruits[end] = self
		player.block[PINEAPPLE_BLOCK] = false
	)
