class_name Ded
extends Node2D


const DED_BLOCK = 'ded_block'

@onready var _field: FieldManager = get_tree().get_first_node_in_group("Field")
@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	_field.set_cell(_field.local_to_map(position), -1)
	_field.registry_ded[_field.local_to_map(position)] = self


func talk(player: Player) -> void:
	player.block[DED_BLOCK] = true

	var dir: Vector2i = _field.local_to_map(player.position - position)
	if dir.x == 1: _sprite.rotation_degrees = -90
	elif dir.x == -1: _sprite.rotation_degrees = 90
	elif dir.y == -1: _sprite.rotation_degrees = 180
	else: _sprite.rotation_degrees = 0

	if false: # puzzle solved
		print("final")

		# when finished:
		# change scene to next one

	else: 
		print('talk')

		# when finished:
		player.block[DED_BLOCK] = false
