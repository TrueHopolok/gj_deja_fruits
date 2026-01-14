extends Node


const SAVE_DATA_PATH: String = "user://save_data.bin"

var unlocked_level: int = 1


func _ready() -> void:
	if not FileAccess.file_exists(SAVE_DATA_PATH): return
	var file: FileAccess = FileAccess.open(SAVE_DATA_PATH, FileAccess.READ)
	unlocked_level = clampi(file.get_8(), 1, 11)
	file.close()


func complete(lvl: int) -> void:
	lvl = clampi(lvl + 1, 1, 11)
	if lvl <= unlocked_level: return
	unlocked_level = lvl
	var file: FileAccess = FileAccess.open(SAVE_DATA_PATH, FileAccess.WRITE)
	file.store_8(unlocked_level)
	file.close()


func reset() -> void:
	unlocked_level = 0
	complete(0)
