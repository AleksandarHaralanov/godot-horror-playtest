extends Node3D


var sensitivity = 0.005

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		get_parent().rotate_y(-event.relative.x * sensitivity)
		rotate_x(-event.relative.y * sensitivity)
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))
