extends TextureRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = Vector2(get_global_mouse_position().x - 40, get_global_mouse_position().y - 40)
	
	if Input.is_action_just_released("LeftMouse"):
		queue_free()
