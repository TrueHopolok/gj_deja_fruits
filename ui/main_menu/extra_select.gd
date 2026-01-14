extends VBoxContainer


func _ready() -> void:
	visible = Persistance.unlocked_level >= 11
