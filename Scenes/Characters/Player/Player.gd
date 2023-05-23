extends CharacterBody3D 

class_name Player

@onready var animation_tree : AnimationTree = $AnimationTree

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	
func _process(_delta):
	pass
