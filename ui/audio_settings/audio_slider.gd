class_name AudioSlider
extends HSlider


const AUDIO_CFG_SECTION: String = "audio_volume"

@export var bus_name: StringName
var _audio_settings: AudioSettings
var _bus_idx: int


func _ready() -> void:
	_bus_idx = AudioServer.get_bus_index(bus_name)
	assert(_bus_idx >= 0, "Error: non existent bus name was set for audio slider '%s'" % bus_name)
	_audio_settings = get_tree().get_first_node_in_group("AudioSettings")
	_audio_settings.read()
	value = _audio_settings.config.get_value(AUDIO_CFG_SECTION, bus_name, AudioServer.get_bus_volume_linear(_bus_idx))
	_on_drag_ended()
	drag_ended.connect(_on_drag_ended)


func _on_drag_ended(_val_changed: bool = true) -> void:
	if !_val_changed: return
	AudioServer.set_bus_volume_linear(_bus_idx, value)
	_audio_settings.config.set_value(AUDIO_CFG_SECTION, bus_name, value)
	_audio_settings.save()
