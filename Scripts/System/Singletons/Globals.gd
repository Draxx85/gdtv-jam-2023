extends Node

func get_direction(vector):
	return int(4.0 * (vector.rotated(PI / 4.0).angle() + PI) / TAU)
	
@onready var tree :SceneTree = get_tree()

signal activate_main_camera()
signal object_entering_camera(object)
signal object_leaving_camera(object)
signal pause_game
signal unpause_game

func _ready():
	pause_game.connect(on_paused)
	unpause_game.connect(on_unpause)
	
func on_paused() -> void:
	tree.paused = true
	
func on_unpause() -> void:
	tree.paused = false

func is_paused() -> bool:
	return tree.paused
