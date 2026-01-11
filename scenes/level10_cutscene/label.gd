extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 2.0)
	tween.tween_callback(func() -> void:
		get_tree().create_timer(3.0).timeout.connect(func() -> void:
			var tween2 := create_tween()
			tween2.tween_property(self, "modulate", Color(0, 0, 0, 0), 2.0)
		)
	)
