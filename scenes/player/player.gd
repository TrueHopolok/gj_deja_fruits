class_name Player
extends Node2D


@onready var _field: FieldManager = get_tree().get_first_node_in_group("Field")
@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D
var _moving: bool = false


func _ready() -> void:
	_field.set_cell(_field.local_to_map(position), -1)


func _process(_delta: float) -> void:
	if _moving: return

	var pos: Vector2i = _field.local_to_map(position)
	var target: Vector2i = pos

	if Input.is_action_pressed(&'move_up'):
		if pos.y <= 0: return
		target.y -= 1
	elif Input.is_action_pressed(&'move_left'):
		if pos.x <= 0: return
		target.x -= 1
	elif Input.is_action_pressed(&'move_right'):
		if pos.x >= Global.FIELD_SIZE.x-1: return
		target.x += 1
	elif Input.is_action_pressed(&'move_down'):
		if pos.y >= Global.FIELD_SIZE.y-1: return
		target.y += 1
	else: return # different input was recieved

	if _field.registry_ded == target: # ded
		# TODO: execute ded related script
		return

	if _field.registry_danger.has(target):
		# TODO: warn player about the danger
		return

	var pushing: bool = false
	if _field.registry_fruits.has(target):
		var fruit: Fruit = _field.registry_fruits[target]
		pushing = true
		fruit.push(pos, target)

	var id = _field.get_cell_source_id(target)
	if (id != -1): return # collision with an object

	_moving = true 
	_sprite.play(&'pushing' if pushing else &'moving')
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", _field.map_to_local(target), Global.MOVE_TIME)
	tween.tween_callback(func()->void: 
		_moving = false 
		_sprite.play(&'idle')
	)
