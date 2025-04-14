extends Panel

@onready var arrow_rotation: Node3D = $"../../SingleQubit/OuterSphere/ArrowRotation"
@onready var arrow_tip_position_node: CSGBox3D = $"../../SingleQubit/OuterSphere/ArrowTipPositionNode"

func _on_set_zero_qubit_button_down() -> void:
	if not (arrow_rotation.is_playing or arrow_rotation.is_tween_paused):
		arrow_tip_position_node.position = Vector3(0, 0.5, 0)

func _on_set_one_qubit_button_down() -> void:
	if not (arrow_rotation.is_playing or arrow_rotation.is_tween_paused):
		arrow_tip_position_node.position = Vector3(0, -0.5, 0)

func _on_set_plus_qubit_button_down() -> void:
	if not (arrow_rotation.is_playing or arrow_rotation.is_tween_paused):
		arrow_tip_position_node.position = Vector3(0, 0, 0.5)

func _on_set_minus_qubit_button_down() -> void:
	if not (arrow_rotation.is_playing or arrow_rotation.is_tween_paused):
		arrow_tip_position_node.position = Vector3(0, 0, -0.5)
