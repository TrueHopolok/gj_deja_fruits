class_name Player
extends Node2D

@onready var _field: TileMapLayer = get_tree().get_first_node_in_group("Field")
 

func _ready() -> void:
	print(_field.local_to_map(position)) # check pos of the player at start


func _input(_event: InputEvent) -> void:
	# give momentum
	# check collisions
	# move yourself
	pass
