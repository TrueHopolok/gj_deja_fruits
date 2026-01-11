extends HSlider

@export var bus_name: StringName

var _bus_idx: int


func _ready() -> void:
	_bus_idx = AudioServer.get_bus_index(bus_name)
	assert(_bus_idx >= 0, "Error: non existent bus name was set for audio slider '%s'" % bus_name)
	value = AudioServer.get_bus_volume_linear(_bus_idx)
	value_changed.connect(_on_value_changed)


func _on_value_changed(volume: float) -> void:
	AudioServer.set_bus_volume_linear(_bus_idx, volume)
