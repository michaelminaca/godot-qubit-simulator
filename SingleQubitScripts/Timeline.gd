extends Panel

@onready var arrow_rotation: Node3D = $"../../SingleQubit/OuterSphere/ArrowRotation"
@onready var play_button: TextureButton = $Playback/PlayButton
@onready var timeline_slots_container: HBoxContainer = $TimelineSlotsContainer
@onready var cancel_button: TextureButton = $Playback/CancelButton

@export_file var play_texture_normal
@export_file var play_texture_playing
@export_file var play_texture_paused

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var current_gate_index = arrow_rotation.current_gate_index_playing
	
	if arrow_rotation.is_playing:
		play_button.texture_normal = load(play_texture_playing)
		cancel_button.disabled = false
	elif arrow_rotation.is_tween_paused:
		play_button.texture_normal = load(play_texture_paused)
		cancel_button.disabled = false
	else:
		play_button.texture_normal = load(play_texture_normal)
		cancel_button.disabled = true
