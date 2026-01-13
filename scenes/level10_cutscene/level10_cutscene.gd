extends Control


var a: bool = true
var b: bool = true


func _ready() -> void:
	$AudioStreamPlayer.finished.connect(func()->void:
		$VideoStreamPlayer.visible = true
		$VideoStreamPlayer.play()
	)
	$VideoStreamPlayer.finished.connect(func()->void:
		Transition.change_scene(load("res://scenes/levels/main/level_10_2.tscn"))
	)


func _process(_delta: float) -> void:
	if a && $VideoStreamPlayer.stream_position >= 10.5: # magic constant
		a = false
		var text: Array[String] = ["I have to go back"] 
		$Textbox.set_text(text, {0: "boy"}, true)
	if b && $VideoStreamPlayer.stream_position >= 14.5:
		b = false
		$Textbox.visible = false
