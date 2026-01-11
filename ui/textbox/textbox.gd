class_name Textbox
extends Node2D


signal finished_outro

var AUDIO_STREAM: Dictionary = {
	"angry": load("res://audio/sfx/ded/gameDed_Speak-Angry.wav"),
	"normal": load("res://audio/sfx/ded/gameDed_Speak-Normal.wav"),
	"worry": load("res://audio/sfx/ded/gameDed_Speak-Questioned.wav"),
}
@export var text_speed: float = 0.1
@onready var _dedsprite: Node2D = $DedSprite
@onready var _boysprite: Node2D = $BoySprite
@onready var _dedsfx: AudioStreamPlayer = $DedSFX
@onready var _dedmounth: AnimatedSprite2D = $DedSprite/DedSprite/Mounth
@onready var _dedeyebrows: AnimatedSprite2D = $DedSprite/DedSprite/Eyebrows
@onready var _label : Label = $Label
@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var _aniplayer: AnimationPlayer = $AnimationPlayer
var _emotions: Dictionary = {}
var _char_index : int = 0
var _current_text : String = ""
var _paragraph_index: int = 0
var _paragraphs: Array[String]
var active: bool = false
var printing: bool = false
var _time: float
var _executing: bool
var block: bool = false


func _ready() -> void:
	_aniplayer.animation_finished.connect(_finished_animation)


func _process(_delta: float) -> void:
	if block: return
	if !printing: return

	if _executing:
		if _time < 0:
			if _char_index < len(_current_text):
				_label.text += _current_text[_char_index]
				_char_index += 1
			else: _stop_talking()
		else: _time -= _delta

	if Input.is_action_just_pressed(&"skip_dialog"):
		if _char_index < len(_current_text):
			_label.text = _current_text
			_char_index = len(_current_text)
		elif _paragraph_index < len(_paragraphs) - 1:
			_paragraph_index += 1
			_start_talking()
			_label.text = ""
			_char_index = 0
			_current_text = _paragraphs[_paragraph_index]
		else:
			printing = false
			_play_outro()


func set_text(paragraphs: Array[String], emotions: Dictionary) -> void:
	if len(paragraphs) == 0: 
		finished_outro.emit()
		return
	active = true
	_paragraph_index = 0
	_paragraphs = paragraphs
	_current_text = paragraphs[0]
	_char_index = 0
	_emotions = emotions
	_play_intro()


func _hide_sprites() -> void:
	_dedsprite.modulate = Color(0, 0, 0)
	_boysprite.modulate = Color(0, 0, 0)


func _stop_talking() -> void:
	_executing = false
	_dedmounth.play("idle")
	_dedsfx.stop()


func _start_talking() -> void:
	_executing = true
	_time = text_speed
	if _emotions.has(_paragraph_index):
		match _emotions[_paragraph_index]:
			"lvl10":
				block = true
				_stop_talking()
				_hide_sprites()
				var tween := create_tween()
				tween.tween_property(%AudioStreamPlayer, "volume_linear", 0.0, 5.0)
				tween.finished.connect(
					Transition.change_scene.bind(load("res://scenes/level10_cutscene/level10_cutscene.tscn"))
				)
				var tween2 := create_tween()
				tween2.tween_property(%LVL10, "color", Color(0, 0, 0, 1), 4.0)
			'boy':
				_boysprite.modulate = Color(1, 1, 1)
				_dedsprite.modulate = Color(0, 0, 0)
			_:
				_dedsprite.modulate = Color(1, 1, 1)
				_dedmounth.play("talk")
				_dedeyebrows.play(_emotions[_paragraph_index])
				_dedsfx.stream = AUDIO_STREAM[_emotions[_paragraph_index]]
				_dedsfx.play()
				_boysprite.modulate = Color(0, 0, 0)
	else:
		_dedsprite.modulate = Color(1, 1, 1)
		_dedmounth.play("talk")
		_dedeyebrows.play("normal")
		_dedsfx.stream = AUDIO_STREAM["normal"]
		_dedsfx.play()
		_boysprite.modulate = Color(0, 0, 0)


func _play_intro() -> void:
	_hide_sprites()
	_stop_talking()
	_label.text = ""
	visible = true
	_sprite.play(&"intro")
	_aniplayer.play(&"intro")


func _play_outro() -> void:
	_hide_sprites()
	_stop_talking()
	_label.text = ""
	_aniplayer.play(&"outro")


func _finished_animation(_anim_name: StringName) -> void:
	if _anim_name == &"intro":
		printing = true
		_sprite.play(&"idle")
		_start_talking()
	elif _anim_name == &"outro":
		visible = false
		active = false
		finished_outro.emit()
