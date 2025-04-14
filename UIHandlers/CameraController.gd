extends Camera3D

@onready var camera_gimbal: Node3D = $".."
@export var zoom = 1.0
var max_zoom = 1.5
var min_zoom = 0.6
var zoom_speed = 0.15

func _unhandled_input(event):
	if event.is_action_pressed("cam_zoom_in"):
		zoom -= zoom_speed
	if event.is_action_pressed("cam_zoom_out"):
		zoom += zoom_speed
	zoom = clamp(zoom, min_zoom, max_zoom)

func _process(delta):
	var tween = create_tween()
	tween.tween_property(camera_gimbal, "scale", Vector3.ONE * zoom, zoom_speed).set_trans(Tween.TRANS_BOUNCE)
