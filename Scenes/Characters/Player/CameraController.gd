extends Node3D

@export var target : CharacterBody3D
@export var camera_speed : float = 2.0

var target_position : Vector3

var velocity : Vector3
 
# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.activate_main_camera.connect(activate_camera)
	if is_instance_valid(target):
		global_position = target.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_instance_valid(target):
		_move_towards(delta)

func _move_towards(delta) -> void:
	var direction = (target.global_position - transform.origin)#.normalized()
	velocity = direction * camera_speed * delta
	position += velocity
	
func activate_camera() -> void:
	$SpringArm3D2/Camera3D.make_current()
