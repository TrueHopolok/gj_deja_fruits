class_name Ded
extends Node2D


const DED_BLOCK = 'ded_block'

@onready var _textbox: Textbox = get_tree().get_first_node_in_group("Textbox")
@onready var _field: FieldManager = get_tree().get_first_node_in_group("Field")
@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D


func _free_player(player: Player) -> void: 
	player.block[DED_BLOCK] = false
	_textbox.finished_outro.disconnect(_free_player)

func _ready() -> void:
	_field.set_cell(_field.local_to_map(position), -1)
	_field.registry_ded[_field.local_to_map(position)] = self


func talk(player: Player) -> void:
	player.block[DED_BLOCK] = true
	var solution: SolutionManager = get_tree().get_first_node_in_group("Solution")

	var dir: Vector2i = _field.local_to_map(player.position - position)
	if dir.x == 1: _sprite.rotation_degrees = -90 
	elif dir.x == -1: _sprite.rotation_degrees = 90
	elif dir.y == -1: _sprite.rotation_degrees = 180
	else: _sprite.rotation_degrees = 0

	var dio: Dialogue = get_tree().get_first_node_in_group("Dialogue")
	assert(is_instance_valid(dio), "dio ded")
	if solution.solved():
		_textbox.finished_outro.connect(func() -> void:
			var lvl: Level = get_tree().get_first_node_in_group("Level")
			Persistance.complete(lvl.level_num)
			Transition.change_scene(dio.scene_to_change)
		)
		_textbox.set_text(dio.text_solved, dio.is_boy_solved)
	else: 
		_textbox.finished_outro.connect(_free_player.bind(player))
		_textbox.set_text(dio.text_unsolved, dio.is_boy_unsolved)
