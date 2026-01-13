extends Control


func _ready() -> void:
	visible = Persistance.unlocked_level >= 11 && false # TODO, since no extra levels are present yet
