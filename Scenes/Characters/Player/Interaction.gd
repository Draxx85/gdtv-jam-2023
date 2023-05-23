extends Area3D

var target 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("use"):
		if is_instance_valid(target):
			target.use()

func _on_possible_interactable_entered(area):
	print("in Range " + area.name)
	target = area


func _on_area_exited(area):
	print("out of range")
	target = null
