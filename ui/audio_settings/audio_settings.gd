class_name AudioSettings
extends Node


const AUDIO_CFG_PATH = "user://audio.cfg"

var config: ConfigFile = ConfigFile.new()


func _ready() -> void:
	read()


func read() -> void:
	var err := config.load(AUDIO_CFG_PATH)
	if err != Error.OK: print(err)


func save() -> void:
	var err := config.save(AUDIO_CFG_PATH)
	if err != Error.OK: print(err)
