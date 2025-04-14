extends Node

signal gate_placed

@export var populated = false
@export var rotation_radians: float = 0.0
@export var rotation_axis: Vector3 = Vector3.ZERO

@onready var arrow_rotation: Node3D = $"../../../../SingleQubit/OuterSphere/ArrowRotation"
@onready var delete_icon: TextureRect = $DeleteIcon
@onready var hover_overlay: ColorRect = $HoverOverlay
@onready var playing_overlay: ColorRect = $PlayingOverlay

var default_texture
var hover_texture

func _ready() -> void:
	gate_placed.connect(get_parent()._on_gate_placed.bind(self))
	hover_overlay.visible = false
	delete_icon.visible = false
	playing_overlay.visible = false
	
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered():
	if not arrow_rotation.is_playing:
		if populated:
			delete_icon.visible = true
		elif Input.is_action_pressed("LeftMouse"):
			hover_overlay.visible = true

func _on_mouse_exited():
	delete_icon.visible = false
	hover_overlay.visible = false
	

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if data.is_in_group("q_gate") and not (arrow_rotation.is_playing or arrow_rotation.is_tween_paused):
		return true
	return false
	
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	populated = true
	rotation_radians = data.rotation_radians
	rotation_axis = data.rotation_axis
	self.texture = data.texture
	emit_signal("gate_placed")
	
func _on_delete_button_down() -> void:
	if not (arrow_rotation.is_playing or arrow_rotation.is_tween_paused):
		if get_parent().get_children().size() > 1 and self.populated:
			queue_free()
		rotation_radians = 0.0
		rotation_axis = Vector3.ZERO
