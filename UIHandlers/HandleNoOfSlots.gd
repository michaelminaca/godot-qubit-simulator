extends HBoxContainer

var gate_slot_node = preload("res://ChildScenes/QuantumGateSlot.tscn")
@onready var arrow_rotation: Node3D = $"../../../SingleQubit/OuterSphere/ArrowRotation"

func _process(delta: float) -> void:
	var gate_slots = get_children()
	if arrow_rotation.current_gate_index_playing != -1:
		for i in range(gate_slots.size()):
			if arrow_rotation.current_gate_index_playing == i:
				gate_slots[i].get_child(3).visible = true
			else:
				gate_slots[i].get_child(3).visible = false
	else:
		for i in range(gate_slots.size()):
			gate_slots[i].get_child(3).visible = false

func _on_gate_placed(placed_gate) -> void:
	if gate_slot_node and placed_gate == get_children()[-1]:
		var new_gate_slot = gate_slot_node.instantiate()
		add_child(new_gate_slot)

