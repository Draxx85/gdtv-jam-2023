extends State

@onready var camera : Camera3D = $Camera

func _ready():
	id = "CameraMode"
	_parent._register_state(self)

func _enter_state():
	print("Entering Camera Mode")
	activate_camera()
	
func _update_state(_delta):
	_handle_input_for_camera()
	
func _exit_state():
	deactivate_camera()

func _check_exit_paths()-> void:
	if not Input.is_action_pressed("EnterCameraMode"):
		go_to_state("AdventureMode")
		print("Exiting Camera Mode")

func activate_camera():
	camera.make_current()
	
func deactivate_camera():
	Globals.emit_signal("activate_main_camera")
	
func _handle_input_for_camera():
	var input_vector = Input.get_vector("moveCameraLeft", "moveCameraRight", "moveCameraUp", "moveCameraDown")
	var camera_rotation = camera.transform.basis.get_rotation_quaternion()
	
