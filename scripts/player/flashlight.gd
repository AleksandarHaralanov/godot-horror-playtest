extends SpotLight3D


var toggle: bool = false
var target_energy: float = 0.0

@onready var toggle_off = $ToggleOff
@onready var toggle_on = $ToggleOn

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("toggle_flashlight"):
		if toggle:
			target_energy = 0.0
			toggle_off.play()
		else:
			target_energy = 4.0
			toggle_on.play()
		toggle = !toggle

func _process(delta: float) -> void:
	light_energy = lerp(light_energy, target_energy, delta * 10)
