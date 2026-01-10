extends AnimationPlayer


func _ready() -> void:
	play(&"default")
	seek(randf_range(0.0, get_animation(&"default").length), true)
