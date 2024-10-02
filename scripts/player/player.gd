extends CharacterBody3D

const WALKING_SPEED: float = 3.0
const SPRINTING_SPEED: float = 6.0
const CROUCHING_SPEED: float = 1.5
const JUMP_VELOCITY: float = 4.5
const GRAVITY: float = 12.5
const CAMERA_SENSITIVITY: float = 0.25
const CAMERA_ACCELERATION: float = 5.0

var current_speed: float = 0.0
var head_y_axis: float = 0.0
var camera_x_axis: float = 0.0

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera
@onready var hand: Node3D = $Hand
@onready var flashlight: SpotLight3D = $Hand/Flashlight

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event) -> void:
	if event is InputEventMouseMotion:
		head_y_axis += event.relative.x * CAMERA_SENSITIVITY
		camera_x_axis -= event.relative.y * CAMERA_SENSITIVITY
		
		camera_x_axis = clamp(camera_x_axis, -90, 90)

func _process(delta: float) -> void:
	head.rotation.y = lerp(head.rotation.y, -deg_to_rad(head_y_axis), CAMERA_ACCELERATION * delta)
	camera.rotation.x = lerp(camera.rotation.x, deg_to_rad(camera_x_axis), CAMERA_ACCELERATION * delta)
	
	hand.rotation.y = -deg_to_rad(head_y_axis)
	flashlight.rotation.x = deg_to_rad(camera_x_axis)
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	else:
		velocity.y -= GRAVITY * delta
	
	if Input.is_action_pressed("sprint") and !Input.is_action_pressed("crouch"):
		current_speed = SPRINTING_SPEED
	elif Input.is_action_pressed("crouch") and !Input.is_action_pressed("sprint"):
		current_speed = CROUCHING_SPEED
	else:
		current_speed = WALKING_SPEED
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * current_speed
			velocity.z = direction.z * current_speed
		else:
			velocity.x = move_toward(velocity.x, 0, current_speed)
			velocity.z = move_toward(velocity.z, 0, current_speed)
	
	move_and_slide()
