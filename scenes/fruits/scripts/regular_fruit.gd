class_name RegularFruit
extends Fruit


const FRUITS_BLOCK = 'regular_fruit'

@export var steps: int = 1
@export var AUDIO_STREAM: Array[AudioStream]
@onready var AUDIO_LENGTH: int = len(AUDIO_STREAM)
@onready var _audio: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	super()


func push(player: Player) -> void:
	var pos: Vector2i = _field.local_to_map(position)
	var dir: Vector2i = pos - _field.local_to_map(player.position)
	var end: Vector2i = _move(pos, dir)
	if pos == end: return # haven't moved

	_audio.stream = AUDIO_STREAM[randi() % AUDIO_LENGTH]
	_audio.play()
	player.block[FRUITS_BLOCK] = true
	_field.registry_fruits.erase(pos)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", _field.map_to_local(end), Global.MOVE_TIME)
	tween.tween_callback(func()->void:
		_field.registry_fruits[end] = self
		player.block[FRUITS_BLOCK] = false
	)


func _move(pos: Vector2i, dir: Vector2i) -> Vector2i:
	var remains: int = steps
	var next: Vector2i
	while remains != 0:
		next = pos + dir
		if _field.out_of_range(next): return pos
		if _field.get_cell_source_id(next) != -1: return pos
		if _field.registry_fruits.has(next): return pos
		if _field.registry_ded.has(next): return pos
		pos = next
		remains -= 1
	return pos
