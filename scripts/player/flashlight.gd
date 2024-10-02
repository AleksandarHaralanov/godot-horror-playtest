extends SpotLight3D

var target_energy: float = 0.0

@onready var toggle_off: AudioStreamPlayer3D = $ToggleOff
@onready var toggle_on: AudioStreamPlayer3D = $ToggleOn

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("flashlight"):
		if get_meta("toggle"):
			target_energy = 0.0
			toggle_off.play()
		else:
			target_energy = 4.0
			toggle_on.play()
		set_meta("toggle", !get_meta("toggle"))

func _process(delta: float) -> void:
	light_energy = lerp(light_energy, target_energy, delta * 10)
