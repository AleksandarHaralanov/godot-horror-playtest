extends Node3D

const MOUSE_SENSITIVITY = 0.005
const BOB_FREQUENCY = 2.0
const BOB_AMPLITUDE = 0.04
var t_bob = 0.0

@onready var camera = $Camera

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event) -> void:
	if event is InputEventMouseMotion:
		get_parent().rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		rotation.x = clamp(rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	t_bob += delta * get_parent().velocity.length() * float(get_parent().is_on_floor())
	camera.transform.origin = _headbob(t_bob)

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQUENCY) * BOB_AMPLITUDE
	pos.x = cos(time * BOB_FREQUENCY / 2) * BOB_AMPLITUDE
	return pos
