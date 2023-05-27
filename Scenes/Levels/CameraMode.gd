extends State

@export var camera_mouse_sensitivity : float = 0.005
@export var camera_joystick_sensitivity : float = 0.5
@export var zooom_speed : float = 25

@onready var camera : Camera3D = $Gimbal/Camera
@onready var gimbal_h := $Gimbal
@onready var cam_ui := $Gimbal/Camera/CamUI
@onready var texture_rect : TextureRect = $Gimbal/Camera/CamUI/TextureRect
@onready var player : Player = $"../.."

signal camera_zoom_changed(zoom : float)

var items_in_view : Dictionary
var targetted_items : Node3D
var captured_texture : ImageTexture
func _ready():
	id = "CameraMode"
	_parent._register_state(self)
	Globals.connect("object_entering_camera", _on_object_entering_camera)
	Globals.connect("object_leaving_camera", _on_object_leaving_camera) 
	captured_texture = ImageTexture.new()

func _enter_state():
	print("Entering Camera Mode")
	activate_camera()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	cam_ui.show_camera_ui()
	
func _update_state(delta):
	_handle_input_for_camera(delta)

func _physics_process(delta):
		_snap_picture()
	
func _exit_state():
	deactivate_camera()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	cam_ui.hide_camera_ui()
	_reset_camera()

func _check_exit_paths()-> void:
	if not Input.is_action_pressed("EnterCameraMode"):
		go_to_state("AdventureMode")
		print("Exiting Camera Mode")

func activate_camera():
	camera.make_current()
	
func deactivate_camera():
	Globals.emit_signal("activate_main_camera")
	
func _snap_picture():
	if Input.is_action_just_pressed("snapPicture"):
		cam_ui.hide_camera_ui()
		#need to wait for 2 frames to hide the cam UI. Figure out a better way!
		await get_tree().process_frame
		await get_tree().process_frame
		var viewport = get_viewport()
		var texture = viewport.get_texture()
		var imgtex = ImageTexture.create_from_image(texture.get_image())
		$Gimbal/Camera/CamUI/TextureRect.texture = imgtex
		cam_ui.show_camera_ui()
		
func _on_object_entering_camera(object : Node3D):
	if is_instance_valid(object):
		items_in_view[object.get_instance_id()] = object
	
func _on_object_leaving_camera(object):
	if is_instance_valid(object):
		items_in_view.erase(object.get_instance_id())
	
#Input Management
####################################################
	
func _input(event):
	if (state_is_active):
		if event is InputEventMouseMotion:
			gimbal_h.rotate_y(deg_to_rad(-event.relative.x * camera_mouse_sensitivity))
			camera.rotate_x(deg_to_rad(event.relative.y * camera_mouse_sensitivity))
			gimbal_h.rotation.y = clamp(gimbal_h.rotation.y, deg_to_rad(-35), deg_to_rad(35))
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-25), deg_to_rad(25))

func _handle_input_for_camera(delta):
	var input_vector = Input.get_vector("moveCameraLeft", "moveCameraRight", "moveCameraUp", "moveCameraDown")
	if input_vector != Vector2.ZERO:
		_rotate_camera(input_vector)
	if Input.is_action_pressed("cameraZoomIn"):
		camera.fov = clamp(camera.fov - zooom_speed * delta, 25, 75) 
		if (camera.fov > 25):
			emit_signal("camera_zoom_changed", zooom_speed * delta)
	elif Input.is_action_pressed("cameraZoomOut"):
		camera.fov = clamp(camera.fov + zooom_speed * delta, 25, 75) 
		if (camera.fov < 75):
			emit_signal("camera_zoom_changed", -zooom_speed * delta)
	
func _rotate_camera(input_vector : Vector2):
	gimbal_h.rotate_y(-deg_to_rad(input_vector.x) * camera_joystick_sensitivity)
	camera.rotate_x(deg_to_rad(input_vector.y) * camera_joystick_sensitivity)
	gimbal_h.rotation.y = clamp(gimbal_h.rotation.y, deg_to_rad(-35), deg_to_rad(35))
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-25), deg_to_rad(25))

func _reset_camera():
	camera.fov = 75
	camera.rotation_degrees.x = 0
	gimbal_h.rotation_degrees.y = 0

###########################################################
