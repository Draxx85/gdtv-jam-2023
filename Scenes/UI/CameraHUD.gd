extends Control

@onready var visibility := $"Visibility Layer"
@onready var activity_bar := $"Visibility Layer/Boarder/TextureProgressBar"
@onready var camera_zoom_reticle := $"Visibility Layer/Boarder/NinePatchRect/CameraZoomReticle"

@onready var reticle_default_orientation : float = camera_zoom_reticle.rotation

var zoom_reticle_multiplier := 3.0

# Called when the node enters the scene tree for the first time.
func _ready():
	visibility.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visibility.visible:
		pass


func hide_camera_ui():
	visibility.visible = false
	
func show_camera_ui():
	visibility.visible = true

func _on_camera_mode_camera_zoom_changed(zoom):
	camera_zoom_reticle.rotation_degrees += zoom * zoom_reticle_multiplier  
