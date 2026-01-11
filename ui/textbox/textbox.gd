class_name Textbox
extends Node2D


signal finished_outro

@onready var _label : Label = $Label
@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var _aniplayer: AnimationPlayer = $AnimationPlayer
var _char_index : int = 0
var _current_text : String = ""
var _paragraph_index: int = 0
var _paragraphs: Array[String]
var active: bool = false
var printing: bool = false


func _ready() -> void:
	_aniplayer.animation_finished.connect(_finished_animation)


func _process(_delta: float) -> void:
	if !printing: return

	if _char_index < len(_current_text):
		_label.text += _current_text[_char_index]
		_char_index+=1
		
	if Input.is_action_just_pressed(&"skip_dialog"):
		if _char_index < len(_current_text):
			_label.text = _current_text
			_char_index = len(_current_text)
		elif _paragraph_index < len(_paragraphs):
			_label.text = ""
			_char_index = 0
			_current_text = _paragraphs[_paragraph_index]
			_paragraph_index += 1
		else:
			printing = false
			_play_outro()


func set_text(paragraphs: Array[String], _is_boy: Dictionary) -> void:
	active = true
	_paragraph_index = 1
	_paragraphs = paragraphs
	_current_text = paragraphs[0]
	_char_index = 0
	_label.text = ""
	_play_intro()


func _play_intro() -> void:
	visible = true
	_sprite.play(&"intro")
	_aniplayer.play(&"intro")


func _play_outro() -> void:
	_aniplayer.play(&"outro")


func _finished_animation(_anim_name: StringName) -> void:
	if _anim_name == &"intro":
		printing = true
		_sprite.play(&"idle")
	elif _anim_name == &"outro":
		visible = false
		active = false
		finished_outro.emit()
