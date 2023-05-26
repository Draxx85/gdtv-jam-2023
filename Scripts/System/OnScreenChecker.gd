extends VisibleOnScreenNotifier3D

@export var interactable : Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_screen_entered():
	Globals.emit_signal("object_entering_camera", interactable)

func _on_screen_exited():
	Globals.emit_signal("object_leaving_camera", interactable)


