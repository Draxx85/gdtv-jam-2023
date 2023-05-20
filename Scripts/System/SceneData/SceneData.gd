extends Resource
class_name SceneData

@export var scene : PackedScene

func traverse_scene():
	if (scene):
		GameManager.load_level(scene)
