extends Node2D

var _current_text : String = ""
var _paragraphs: Array

@onready var _label : Label = $Label

var _char_index : int = 0
var _paragraph_index: int = 0
func _process(_delta: float) -> void:
	if !visible:
		return
	if _char_index<len(_current_text):
		_label.text += _current_text[_char_index]
		_char_index+=1
	if Input.is_action_just_pressed("skip_dialog"):
		if _char_index<len(_current_text):
			_label.text = _current_text
			_char_index = len(_current_text)
		elif _paragraph_index < len(_paragraphs):
			_label.text = ""
			_char_index = 0
			_current_text = _paragraphs[_paragraph_index]
			_paragraph_index+=1
		else:
			visible=false
func set_text(paragraphs: Array) -> void:
	_paragraph_index = 1
	_paragraphs = paragraphs
	_current_text = paragraphs[0]
	_char_index = 0
