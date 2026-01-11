class_name Player
extends Node2D


const SPRITE_ROTATION = deg_to_rad(90)

@export var AUDIO_STREAM: Array[AudioStream]
@onready var AUDIO_LENGTH: int = len(AUDIO_STREAM)

@onready var _field: FieldManager = get_tree().get_first_node_in_group("Field")
@onready var _audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D
var block: Dictionary = {}
var _moving: bool = false


func _ready() -> void:
	_field.set_cell(_field.local_to_map(position), -1)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"restart"): Transition.change_scene(load(get_tree().current_scene.name))

	if _moving: return
	if block.values().any(func(bl: bool)->bool: return bl): return

	var pos: Vector2i = _field.local_to_map(position)
	var dir: Vector2i = Vector2i.ZERO
	if event.is_action_pressed(&"move_up"): dir = Vector2i.UP
	elif event.is_action_pressed(&"move_down"): dir = Vector2i.DOWN
	elif event.is_action_pressed(&"move_left"): dir = Vector2i.LEFT
	elif event.is_action_pressed(&"move_right"): dir = Vector2i.RIGHT
	else: return # different input was recieved
	_sprite.rotation = Vector2(dir).angle() + SPRITE_ROTATION
	var end: Vector2i = pos + dir

	if _field.out_of_range(end): return
	if _field.get_cell_source_id(end) != -1: return # collision with a wall
	if _field.registry_ded.has(end):
		_field.registry_ded[end].talk(self)
		return
	if _field.registry_danger.has(end):
		# TODO: warn player about the danger
		return

	if _field.registry_fruits.has(end):
		var fruit: Fruit = _field.registry_fruits[end]
		if is_instance_of(fruit, DragonFruit): return # impossible to happen
		fruit.push(self)
		if _field.registry_fruits.has(end): return # fruit haven't moved

	if _field.registry_fruits.has(pos - dir):
		var pineapple: Variant = _field.registry_fruits[pos - dir]
		if is_instance_of(pineapple, Pineapple): pineapple.follow(self)

	_moving = true
	if AUDIO_LENGTH > 0: _audio.stream = AUDIO_STREAM[randi() % AUDIO_LENGTH]
	_audio.play()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", _field.map_to_local(end), Global.MOVE_TIME)
	tween.tween_callback(func()->void: _moving = false )
