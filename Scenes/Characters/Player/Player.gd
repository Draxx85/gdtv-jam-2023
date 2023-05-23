extends CharacterBody3D

@onready var animation_tree : AnimationTree = $AnimationTree
var is_facing_right : bool
var is_turning : bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

enum FacingDirection { left, right}

var facing_direction = FacingDirection.right

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
func _process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	
	#var desired_direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if input_dir != Vector2.ZERO:
		look_at(global_transform.origin + -Vector3(input_dir.x, 0, input_dir.y), Vector3.UP)
	
	var currentRotation = transform.basis.get_rotation_quaternion()
	var vel = (currentRotation.normalized() * animation_tree.get_root_motion_position())

	animation_tree.set("parameters/IdleWalk/blend_position", input_dir.length())
	velocity = Vector3(vel.x / delta, velocity.y / delta, vel.z / delta)

	move_and_slide()
