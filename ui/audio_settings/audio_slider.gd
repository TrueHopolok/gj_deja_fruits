extends HSlider


const AUDIO_CFG_PATH = "user://audio.cfg"

@export var bus_name: StringName
var _bus_idx: int


func _ready() -> void:
	_bus_idx = AudioServer.get_bus_index(bus_name)
	assert(_bus_idx >= 0, "Error: non existent bus name was set for audio slider '%s'" % bus_name)
	value = _read_cfg()
	AudioServer.set_bus_volume_linear(_bus_idx, value)
	value_changed.connect(_on_value_changed)


func _on_value_changed(volume: float) -> void:
	AudioServer.set_bus_volume_linear(_bus_idx, volume)
	_update_cfg()


func _read_cfg() -> float:
	if not FileAccess.file_exists(AUDIO_CFG_PATH): return AudioServer.get_bus_volume_linear(_bus_idx)
	var save_file: FileAccess = FileAccess.open(AUDIO_CFG_PATH, FileAccess.READ)
	var audio_volumes: Dictionary = JSON.parse_string(save_file.get_line())
	save_file.close()
	return audio_volumes[bus_name]


func _update_cfg() -> void:
	var audio_volumes: String = JSON.stringify({
		"Master": AudioServer.get_bus_volume_linear(AudioServer.get_bus_index(&'Master')),
		"Music": AudioServer.get_bus_volume_linear(AudioServer.get_bus_index(&'Music')),
		"SFX": AudioServer.get_bus_volume_linear(AudioServer.get_bus_index(&'SFX')),
	})
	var save_file: FileAccess = FileAccess.open(AUDIO_CFG_PATH, FileAccess.WRITE)
	save_file.store_string(audio_volumes)
	save_file.close()
