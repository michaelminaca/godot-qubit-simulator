extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_child(0).visible = false
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered():
	get_child(0).visible = true

func _on_mouse_exited():
	get_child(0).visible = false
