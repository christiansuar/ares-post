extends CharacterBody3D

var speed
const SPRINT_SPEED = 9
const WALK_SPEED = 2.0
const JUMP_VELOCITY = 4.5
const gravity = 9.8
var sensitivity = 0.004

# bob is short for bobble (camera bobble) 
# freq is how frequent the bobble happens
# amp is how much the camera moves (short for amplitude)
const bob_freq = 2.5
const bob_amp = 0.08
var t_bob = 0.0

@onready var head = $HeadPivot
@onready var head_camera = $HeadPivot/Camera3D

func _ready():

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			rotate_y(-event.relative.x * sensitivity)
			head_camera.rotate_x(-event.relative.y * sensitivity)
			head_camera.rotation.x = clamp(head_camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
			
		
		
func _physics_process(delta):
	#print(position)
	# click the escape button to show mouse again
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("left_click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	# Handle Sprint
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED
		
	# Get the input direction and handle the movement/deceleration.

	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
		
	#head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	head_camera.transform.origin = _headbob(t_bob)
	
	move_and_slide()
	

	
	#frames
	#print("Frames: " + str(Engine.get_frames_per_second()))
	
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * bob_freq) * bob_amp
	pos.x = cos(time * bob_freq/2) * bob_amp 
	return pos
