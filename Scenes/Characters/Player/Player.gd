extends CharacterBody3D 

class_name Player

@export var photo_album_size := 3

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var photos : Array
@onready var tree : SceneTree = get_tree()

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	
func _process(_delta):
	if Input.is_action_just_pressed("photoMenu"):
		pass

func add_photo_to_album(img : ImageTexture):
	if photos.size() <= photo_album_size:
		photos.append(img)
	else:
		photos.pop_front()
		photos.append(img)
		
func _on_pause_screen_on_unpause():
	tree.paused = false
