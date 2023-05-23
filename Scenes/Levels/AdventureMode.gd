extends State

@onready var player : Player = $"../.."
@onready var animation_tree = $"../../AnimationTree"

func _ready():
	id = "AdventureMode"
	_parent._register_state(self)

func _enter_state():
	pass
	
func _update_state(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	
	#var desired_direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if input_dir != Vector2.ZERO:
		player.look_at(player.global_transform.origin + -Vector3(input_dir.x, 0, input_dir.y), Vector3.UP)
	
	var currentRotation = player.transform.basis.get_rotation_quaternion()
	var vel = (currentRotation.normalized() * animation_tree.get_root_motion_position())

	animation_tree.set("parameters/IdleWalk/blend_position", input_dir.length())
	player.velocity = Vector3(vel.x / delta, player.velocity.y / delta, vel.z / delta)

	player.move_and_slide()
	
func _exit_state():
	pass

func _check_exit_paths():
	if Input.is_action_pressed("EnterCameraMode"):
		animation_tree.set("parameters/IdleWalk/blend_position", 0)
		go_to_state("CameraMode")
	pass

func _physics_process(delta):
	# Add the gravity.
	if not player.is_on_floor():
		player.velocity.y -= player.gravity * delta
	
