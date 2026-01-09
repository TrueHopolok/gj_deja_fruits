class_name DangerZone
extends Node2D


func _ready() -> void:
	var field: FieldManager = get_tree().get_first_node_in_group("Field")
	field.registry_danger[field.local_to_map(position)] = true
