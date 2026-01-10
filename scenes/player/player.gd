class_name Player
extends Node2D


@export var AUDIO_STREAM: Array[AudioStream]
@onready var AUDIO_LENGTH: int = len(AUDIO_STREAM)

@onready var _field: FieldManager = get_tree().get_first_node_in_group("Field")
@onready var _audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D
var ded_block: bool = false
var _moving: bool = false


func _ready() -> void:
	_field.set_cell(_field.local_to_map(position), -1)


func _process(_delta: float) -> void:
	if _moving: return
	if ded_block: return

	var pos: Vector2i = _field.local_to_map(position)
	var dir: Vector2i = Vector2i(
		int(Input.get_axis(&'move_left', &'move_right')),
		int(Input.get_axis(&'move_up', &'move_down'))
	)
	if dir == Vector2i.ZERO: return # different input was recieved
	if dir.x != 0: dir.y = 0 # clamp on 2 axis simontanious press
	
	if dir.x == -1: _sprite.rotation_degrees = -90
	elif dir.x == 1: _sprite.rotation_degrees = 90
	elif dir.y == 1: _sprite.rotation_degrees = 180
	else: _sprite.rotation_degrees = 0
	
	var end: Vector2i = pos + dir

	if _field.out_of_range(end): return

	if _field.get_cell_source_id(end) != -1: return # collision with a wall

	if _field.registry_ded == end:
		print("test")
		return

	if _field.registry_danger.has(end):
		# TODO: warn player about the danger
		return

	if _field.registry_fruits.has(end):
		var fruit: Fruit = _field.registry_fruits[end]
		if is_instance_of(fruit, DragonFruit): return # impossible to happen
		fruit.push(pos, end)
		if _field.registry_fruits.has(end): return # fruit haven't moved

	if _field.registry_fruits.has(pos - dir):
		var pineapple: Variant = _field.registry_fruits[pos - dir]
		if is_instance_of(pineapple, Pineapple): pineapple.follow(pos)

	_moving = true
	if AUDIO_LENGTH > 0: _audio.stream = AUDIO_STREAM[randi() % AUDIO_LENGTH]
	_audio.play()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", _field.map_to_local(end), Global.MOVE_TIME)
	tween.tween_callback(func()->void: 
		_moving = false 
	)
