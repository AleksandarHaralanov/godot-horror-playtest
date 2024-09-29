extends CharacterBody3D

var current_speed = 5.0

const WALKING_SPEED = 5.0
const SPRINTING_SPEED = 10.0
const CROUCHING_SPEED = 2.5

const JUMP_VELOCITY = 4.5

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("sprint") and !Input.is_action_pressed("crouch"):
		current_speed = SPRINTING_SPEED
	elif Input.is_action_pressed("crouch") and !Input.is_action_pressed("sprint"):
		current_speed = CROUCHING_SPEED
	else:
		current_speed = WALKING_SPEED
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
