extends Node

@onready var node: Node = $"../../../../.."


@export var rotation_radians: float
@export var rotation_axis: Vector3

@export_file var default_texture
@export_file var hovered_texture

var drag_preview = preload("res://DragPreview/DragPreview.tscn")

func _ready() -> void:
	self.texture = load(default_texture)
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)

func _on_mouse_entered():
	self.texture = load(hovered_texture)

func _on_mouse_exited():
	self.texture = load(default_texture)

func _get_drag_data(_at_position: Vector2) -> Variant:
	var drag_preview = drag_preview.instantiate()
	drag_preview.texture = self.texture
	node.add_child(drag_preview)
	
	return self
