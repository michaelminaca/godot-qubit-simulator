extends Node3D

var tween
@export var is_tween_paused = false
@export var is_playing = false
@export var current_gate_index_playing = -1
@onready var timeline_slots_container: HBoxContainer = $"../../../UserInterface/Timeline/TimelineSlotsContainer"
@onready var arrow_tip_position_node: CSGBox3D = $"../ArrowTipPositionNode"

func _process(delta: float) -> void:
	if tween is Tween:
		is_playing = tween.is_running()
	safe_look_at(self, arrow_tip_position_node.global_transform.origin)

func tween_step_finished(idx) -> void:
	current_gate_index_playing = floorf(idx / 20)
	
func tween_finished() -> void:
	current_gate_index_playing = -1

func _on_play_button_down() -> void:
	if timeline_slots_container.get_children().size() > 1:
		if not is_playing:
			if not is_tween_paused:
				tween = create_tween()
				tween.connect("step_finished", tween_step_finished)
				tween.connect("finished", tween_finished)
				var intermittent_position = arrow_tip_position_node.position
				for slot in timeline_slots_container.get_children():
					if slot.populated:
						for i in range(20):
							var rotated_pos = intermittent_position.rotated(slot.rotation_axis.normalized(), (PI * slot.rotation_radians)/20)
							tween.tween_property(arrow_tip_position_node, "position", rotated_pos, 0.05)
							intermittent_position = rotated_pos
			else:
				tween.play()
				is_tween_paused = false
		if is_playing:
			tween.pause()
			is_tween_paused = true

func _on_cancel_button_button_down() -> void:
	if tween != null:
		if is_tween_paused:
			tween.play()
		tween.kill()
		is_playing = false
		is_tween_paused = false

func safe_look_at(node : Node3D, target : Vector3) -> void:
	var origin : Vector3 = node.global_transform.origin
	var v_z := (origin - target).normalized()
	if origin == target:
		return
	var up := Vector3.ZERO
	for entry in [Vector3.UP, Vector3.RIGHT, Vector3.BACK]:
		var v_x : Vector3 = entry.cross(v_z).normalized()
		if v_x.length() != 0:
			up = entry
			break
	if up != Vector3.ZERO:
		node.look_at(target, up)


