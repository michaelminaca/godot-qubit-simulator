extends Panel

var zero_state_amplitude: float
var one_state_amplitude: float
var relative_phase_radians: float

@onready var arrow_tip_position_node: CSGBox3D = $"../../SingleQubit/OuterSphere/ArrowTipPositionNode"

@onready var zero_probability_rect: ColorRect = $QubitProbabilitiesContainer/ProbabilitiesGraph/ZeroProbabilityRect
@onready var one_probability_rect: ColorRect = $QubitProbabilitiesContainer/ProbabilitiesGraph/OneProbabilityRect
@onready var zero_probability_label: Label = $QubitProbabilitiesContainer/ProbabilitiesGraph/ZeroProbabilityLabel
@onready var one_probability_label: Label = $QubitProbabilitiesContainer/ProbabilitiesGraph/OneProbabilityLabel

@onready var phase_rotation: Control = $QubitPhaseContainer/Panel/PhaseRotation
@onready var relative_phase_label: Label = $QubitPhaseContainer/RelativePhaseLabel

@onready var arrow_body: ColorRect = $QubitPhaseContainer/Panel/PhaseRotation/ArrowBody
@onready var texture_rect: TextureRect = $QubitPhaseContainer/Panel/PhaseRotation/TextureRect

@onready var zero_amplitude_label: Label = $"../QubitEquationSection/ZeroAmplitudeLabel"
@onready var one_amplitude_label: Label = $"../QubitEquationSection/OneAmplitudeLabel"
@onready var phase_amplitude_label: Label = $"../QubitEquationSection/PhaseAmplitudeLabel"



func _ready() -> void:
	zero_probability_rect.visible = true
	one_probability_rect.visible = true

func _process(delta: float) -> void:
	calculate_amplitude_and_phase()
	zero_probability_label.text = str(round_numbers_to_decimals(zero_state_amplitude, 2))
	one_probability_label.text = str(round_numbers_to_decimals(one_state_amplitude, 2))
	zero_probability_rect.scale.y = -zero_state_amplitude
	one_probability_rect.scale.y = -one_state_amplitude
	
	relative_phase_label.text = round_numbers_to_decimals(relative_phase_radians/PI, 2)
	
	zero_amplitude_label.text = round_numbers_to_decimals(sqrt(zero_state_amplitude), 3)
	one_amplitude_label.text = round_numbers_to_decimals(sqrt(one_state_amplitude), 3)
	phase_amplitude_label.text = round_numbers_to_decimals(relative_phase_radians/PI, 3)
	
	if relative_phase_radians > 0:
		phase_rotation.rotation = -relative_phase_radians
	
	show_hide_phase_arrow()

func show_hide_phase_arrow():
	if relative_phase_radians == 0 and round_places(arrow_tip_position_node.position.x, 3) == 0 and round_places(arrow_tip_position_node.position.z, 3) == 0:
		arrow_body.visible = false
		texture_rect.visible = false
	else:
		arrow_body.visible = true
		texture_rect.visible = true

func calculate_amplitude_and_phase():
	zero_state_amplitude = abs(arrow_tip_position_node.position.y + 0.5) 
	one_state_amplitude = abs(1 - zero_state_amplitude)
	
	var qubit_vector_rounded_pos_x = round_places(arrow_tip_position_node.position.x, 3)
	var qubit_vector_rounded_pos_z = round_places(arrow_tip_position_node.position.z, 3)
	
	relative_phase_radians = atan(qubit_vector_rounded_pos_x / qubit_vector_rounded_pos_z)
	if is_nan(relative_phase_radians):
		relative_phase_radians = 0.0
	if qubit_vector_rounded_pos_x < 0 or qubit_vector_rounded_pos_z < 0:
		relative_phase_radians += PI
	if qubit_vector_rounded_pos_x < 0 and qubit_vector_rounded_pos_z > 0:
		relative_phase_radians += PI
	if qubit_vector_rounded_pos_z == 0 and qubit_vector_rounded_pos_x != 0:
		relative_phase_radians += PI
	relative_phase_radians = abs(relative_phase_radians)

func round_places(num, places):
	return (round(num*pow(10,places))/pow(10,places))

func round_numbers_to_decimals(num, places):
	var rounded_num = str(round(num*pow(10,places))/pow(10,places))
	if not rounded_num.contains("."):
		rounded_num += "."
		for i in range(places):
			rounded_num += "0"
	while rounded_num.length() - 2 < places:
		rounded_num += "0"
	return rounded_num
